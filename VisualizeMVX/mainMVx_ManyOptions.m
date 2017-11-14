close all;clear all;clc;

FileRef="avmv.bin";
%FileRef="mv_JM_QP0.bin";
%FileRef="mv_JM_QP12.bin";
%FileRef="mv_JM_QP51.bin";

File1="mv_Option1.bin";
File2="mv_Option2.bin";
File3="mv_Option3.bin";
File4="mv_Option4.bin";
File5="mv_Option5.bin";

%FileRef=File4;

play=1;
plotfig=0;


[mv_data_OptRef] = load_mv(FileRef, 10, 0) ;
[mv_data_Opt1] = load_mv(File1, 10, 0) ;
[mv_data_Opt2] = load_mv(File2, 10, 0) ;
[mv_data_Opt3] = load_mv(File3, 10, 0) ;
[mv_data_Opt4] = load_mv(File4, 10, 0) ;
[mv_data_Opt5] = load_mv(File5, 10, 0) ;

SizeOptRef=size(mv_data_OptRef,3);
SizeOpt1=size(mv_data_Opt1,3);
SizeOpt2=size(mv_data_Opt2,3);
SizeOpt3=size(mv_data_Opt3,3);
SizeOpt4=size(mv_data_Opt4,3);
SizeOpt5=size(mv_data_Opt5,3);

numFrame = min([SizeOptRef,SizeOpt1,SizeOpt2,SizeOpt3,SizeOpt4,SizeOpt5]) ;

if FileRef=="avmv.bin";
    dx_OptRef = mv_data_OptRef(1:end/2, :, 1:numFrame) ;
    dy_OptRef = mv_data_OptRef((end/2)+1:end, :, 1:numFrame) ;
else
    dx_OptRef = mv_data_OptRef(1:end/2, :, 1:numFrame) ;
    dy_OptRef = mv_data_OptRef((end/2)+1:end, :, 1:numFrame) ;
end

dx_Opt1 = mv_data_Opt1(1:end/2, :, 1:numFrame) ;
dy_Opt1 = mv_data_Opt1((end/2)+1:end, :, 1:numFrame) ;

dx_Opt2 = mv_data_Opt2(1:end/2, :, 1:numFrame) ;
dy_Opt2 = mv_data_Opt2((end/2)+1:end, :, 1:numFrame) ;

dx_Opt3 = mv_data_Opt3(1:end/2, :, 1:numFrame) ;
dy_Opt3 = mv_data_Opt3((end/2)+1:end, :, 1:numFrame) ;

dx_Opt4 = mv_data_Opt4(1:end/2, :, 1:numFrame) ;
dy_Opt4 = mv_data_Opt4((end/2)+1:end, :, 1:numFrame) ;

dx_Opt5 = mv_data_Opt5(1:end/2, :, 1:numFrame) ;
dy_Opt5 = mv_data_Opt5((end/2)+1:end, :, 1:numFrame) ;

sqdiff_dx_Opt1Ref = dx_OptRef - dx_Opt1 ;
sqdiff_dx_Opt1Ref = sqdiff_dx_Opt1Ref.^2 ;

sqdiff_dy_Opt1Ref = dy_OptRef - dy_Opt1 ;
sqdiff_dy_Opt1Ref = sqdiff_dy_Opt1Ref.^2 ;


sqdiff_dx_Opt2Ref = dx_OptRef - dx_Opt2 ;
sqdiff_dx_Opt2Ref = sqdiff_dx_Opt2Ref.^2 ;

sqdiff_dy_Opt2Ref = dy_OptRef - dy_Opt2 ;
sqdiff_dy_Opt2Ref = sqdiff_dy_Opt2Ref.^2 ;


sqdiff_dx_Opt3Ref = dx_OptRef - dx_Opt3 ;
sqdiff_dx_Opt3Ref = sqdiff_dx_Opt3Ref.^2 ;

sqdiff_dy_Opt3Ref = dy_OptRef - dy_Opt3 ;
sqdiff_dy_Opt3Ref = sqdiff_dy_Opt3Ref.^2 ;

sqdiff_dx_Opt4Ref = dx_OptRef - dx_Opt4 ;
sqdiff_dx_Opt4Ref = sqdiff_dx_Opt4Ref.^2 ;

sqdiff_dy_Opt4Ref = dy_OptRef - dy_Opt4 ;
sqdiff_dy_Opt4Ref = sqdiff_dy_Opt4Ref.^2 ;


sqdiff_dx_Opt5Ref = dx_Opt5 - dx_OptRef ;
sqdiff_dx_Opt5Ref = sqdiff_dx_Opt5Ref.^2 ;

sqdiff_dy_Opt5Ref = dy_Opt5 - dy_OptRef ;
sqdiff_dy_Opt5Ref = sqdiff_dy_Opt5Ref.^2 ;

sumsqdiff_Opt1Ref = sqdiff_dx_Opt1Ref + sqdiff_dy_Opt1Ref ;
sumsqdiff_Opt2Ref = sqdiff_dx_Opt2Ref + sqdiff_dy_Opt2Ref ;
sumsqdiff_Opt3Ref = sqdiff_dx_Opt3Ref + sqdiff_dy_Opt3Ref ;
sumsqdiff_Opt4Ref = sqdiff_dx_Opt4Ref + sqdiff_dy_Opt4Ref ;
sumsqdiff_Opt5Ref = sqdiff_dx_Opt5Ref + sqdiff_dy_Opt5Ref ;

for i=1:numFrame
    epe_Opt1Ref(i) = mean(mean(sumsqdiff_Opt1Ref(:,:,i)));
    epe_Opt2Ref(i) = mean(mean(sumsqdiff_Opt2Ref(:,:,i)));
    epe_Opt3Ref(i) = mean(mean(sumsqdiff_Opt3Ref(:,:,i)));
    epe_Opt4Ref(i) = mean(mean(sumsqdiff_Opt4Ref(:,:,i)));
    epe_Opt5Ref(i) = mean(mean(sumsqdiff_Opt5Ref(:,:,i)));
end

[SizeOptRef SizeOpt1 SizeOpt2 SizeOpt3 SizeOpt4 SizeOpt5]

epe_Opt1Ref_av=mean(epe_Opt1Ref);
epe_Opt2Ref_av=mean(epe_Opt2Ref);
epe_Opt3Ref_av=mean(epe_Opt3Ref);
epe_Opt4Ref_av=mean(epe_Opt4Ref);
epe_Opt5Ref_av=mean(epe_Opt5Ref);

T_OptRef=max(max(max(sqrt(dx_OptRef.^2+dy_OptRef.^2))));
T_Opt1=max(max(max(sqrt(dx_Opt1.^2+dy_Opt1.^2))));
T_Opt2=max(max(max(sqrt(dx_Opt2.^2+dy_Opt2.^2))));
T_Opt3=max(max(max(sqrt(dx_Opt3.^2+dy_Opt3.^2))));
T_Opt4=max(max(max(sqrt(dx_Opt3.^2+dy_Opt4.^2))));
T_Opt5=max(max(max(sqrt(dx_Opt3.^2+dy_Opt5.^2))));

[T_OptRef T_Opt1 T_Opt2 T_Opt3 T_Opt4 T_Opt5]

[epe_Opt1Ref_av epe_Opt2Ref_av epe_Opt3Ref_av epe_Opt4Ref_av epe_Opt5Ref_av]


if plotfig
    plot(1:numFrame,epe_Opt1Ref,'-rd');
    hold on;
    plot(1:numFrame,epe_Opt2Ref,':rd');
    plot(1:numFrame,epe_Opt3Ref,'-ko');
    plot(1:numFrame,epe_Opt4Ref,':ko');
    plot(1:numFrame,epe_Opt5Ref,'-b*');
    title('Compute EPE of MVs')
    legend('Option1','Option2','Option3','Option4','Option5');
end
if play
    implay(10*(sqrt(dx_Opt1.^2+dy_Opt1.^2))/T_Opt1,12);
    implay(10*(sqrt(dx_Opt2.^2+dy_Opt2.^2))/T_Opt2,12);
    implay(10*(sqrt(dx_Opt3.^2+dy_Opt3.^2))/T_Opt3,12);
    implay(10*(sqrt(dx_Opt4.^2+dy_Opt4.^2))/T_Opt4,12);
    implay(10*(sqrt(dx_Opt5.^2+dy_Opt5.^2))/T_Opt5,12);
    implay(10*(sqrt(dx_OptRef.^2+dy_OptRef.^2))/T_OptRef,12);
end