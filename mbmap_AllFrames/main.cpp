#include "define.h"

#include <stdio.h>
#include <stdlib.h>

// Input parameters
bool GRID_8X8, GRID_4X4, SHOW_HELP ; 
int FRAME_WIDTH ; int FRAME_HEIGHT ;
const char *INPUT_PATH, *OUTPUT_PATH ;


int main(int argc, const char* argv[])
{
	Helper::parse_options(argc, argv);

	int mbsize ; mbsize = GRID_8X8 ? 8:16 ;
	
	//echo start execution	
	int MBGrid = GRID_4X4 ? 4:mbsize;
        fprintf(stdout ,"\n\nMabing MV of JM software to %dx%d grid\n",MBGrid, MBGrid) ;


	// Read MVs and load into vector
	JMacroBlock mb ; vector<JMacroBlock> mbvec ;

        FILE * pFile;
        pFile = fopen ( INPUT_PATH , "rb" );
        if (pFile==NULL) {fputs ("File error",stderr); exit (1);}
    
        long lSize ; int *buffer ; size_t result ;
        
        // obtain file size:
        fseek (pFile , 0 , SEEK_END) ; lSize = ftell(pFile) ;
        rewind (pFile);
        
        // Allocate buffer memory 
        buffer = (int*) malloc (lSize);
        if (buffer == NULL) {fputs ("Memory error",stderr); exit (2);}
        
        // copy the file into the buffer:
	//fprintf(stdout ,"lSize: %d, lSize/sizeof(int): %d\n", lSize, lSize/sizeof(int)) ;
        result = fread(buffer,sizeof(int),lSize/sizeof(int),pFile); fclose (pFile) ;
        if (result != lSize/sizeof(int)) {fputs ("Reading Error\n",stderr); exit (3);}

	Frame frame ; int last_frame = -1 ; int inc_frame = 0 ; int zero_mv_frame_num=0;
	frame.width = FRAME_WIDTH ; frame.height = FRAME_HEIGHT ;
	frame.type = 0 ; 
	
	FILE  *fout = fopen(OUTPUT_PATH, "wb") ;
	int   *buffer_ = buffer ; int bytes_read = 0 ; int cnt = 0;
	while(bytes_read < (lSize - sizeof(JMacroBlock) - 1)){
		mbvec.clear() ;
		bool same_frame = true ;
		fprintf(stdout, "."); 
		while((same_frame)) {
		mb.frame = *(buffer_++) ; mb.type = *(buffer_++) ;
		mb.x     = *(buffer_++) ; mb.y    = *(buffer_++) ;
		mb.dx    = *(buffer_++) ; mb.dy   = *(buffer_++) ;
		//fprintf(stdout ,"total_bytes: %d, bytes_read: %d\n", lSize, bytes_read) ; 
		//fprintf(stdout ,"frame: %d, type: %d, x:%d, y:%d, dx: %d. dy:%d\n", mb.frame, mb.type, mb.x, mb.y, mb.dx, mb.dy) ; 

		same_frame = (mb.frame == last_frame) ;
		inc_frame = mb.frame - last_frame; //added by jubran - strart from this line

		bytes_read = bytes_read + sizeof(JMacroBlock) ;
                //fprintf(stdout ,"MB:last_frame: %d, mb.frame=%d\n", last_frame,mb.frame) ; 
		mbvec.push_back(mb) ;
		last_frame = mb.frame ; }
                //fprintf(stdout ,"last_frame: %d, mb.frame=%d, inc_frame=%d\n", last_frame,mb.frame,inc_frame) ;
		//fprintf(stdout ,"frame: %d [%d]\n", mb.frame,inc_frame) ;  //added by jubran
		//fprintf(stdout ,"frame: %d, type: %d, x:%d, y:%d, dx: %d. dy:%d\n", mb.frame-inc_frame, mb.type, mb.x, mb.y, mb.dx, mb.dy) ; //added by jubran
		frame.setup(mbvec) ; 
		frame.smooth() ; 
                fprintf(stdout ,"last_frame: %d, mb.frame=%d\n", last_frame,mb.frame) ;
		frame.print(fout,last_frame)  ;

                while (( cnt <  (inc_frame - 1) )) //added by jubran - start from this line
		{
		//mbvec.clear() ;
		zero_mv_frame_num=mb.frame - inc_frame + cnt + 1;
		//fprintf(stdout ,"No MV Frame: %d\n", zero_mv_frame_num) ;
		cnt++;

		//mb.frame=zero_mv_frame_num;
		//mb.type=0;mb.x=0;mb.y=0;mb.dx=0;mb.dy=0;
		//fprintf(stdout ,"0000000000000000 Zero MV frame: %d, type: %d, x:%d, y:%d, dx: %d. dy:%d\n", mb.frame, mb.type, mb.x, mb.y, mb.dx, mb.dy) ; //added by jubran
		frame.setup_zero(mbvec) ;
                //fprintf(stdout ,"missed: last_frame: %d, mb.frame=%d\n", last_frame,zero_mv_frame_num) ;
		frame.print_zero(fout,zero_mv_frame_num)  ;
		}

   		inc_frame=0;cnt=0;             //added by jubran - ... end
	}

        free (buffer) ; fclose(fout) ;
        fprintf(stdout,"\n\n");
	return 0;
} // main

   
	
/*










  // the iterator constructor can also be used to construct from arrays:
  int myints[] = {16,2,77,29};
  std::vector<int> fifth (myints, myints + sizeof(myints) / sizeof(int) );

  std::cout << "The contents of fifth are:";
  for (std::vector<int>::iterator it = fifth.begin(); it != fifth.end(); ++it)
    std::cout << ' ' << *it;
  std::cout << '\n';

	clock_t begin = clock();

	AVL_H264 avlh = AVL_H264() ;
	avlh.initialize() ;	
	clock_t begin_ffinit = clock();
	while(avlh.get_motion_vectors()){continue ;}

	clock_t end = clock();
	double time_spent_stdout = (double)(end - begin) / CLOCKS_PER_SEC;

	fprintf(stdout, "Runtime: %f\n", (time_spent_stdout));

}
*/
