function [FNames ,FrameNo, VideoRates, AvRateKbits]=Rate_Load_Function(filename, FPS)

%filename='Size_Orig_NOTexture_Test01_QP20_MVSR16_MVRes8_A.dat'
%FPS=25;
ToPrint=0;

%% Load file contents ...
fid = fopen(filename,'r') ;
tline = fgetl(fid);
tline = fgetl(fid);
cnt2=1;
SizeArray=[];
FNames=blanks(1);
WriteFileName=0;
while ischar(tline)
    %    disp(tline)
    NumaricLine=double(tline)-48;
    cnt1=1;
    cnt3=1;
    SizeArrayTemplate=zeros(1,7);
    SizeArray=[SizeArray;SizeArrayTemplate];
    for l=1:length(NumaricLine)
        if ( NumaricLine(l)== -16 )
            cnt1=cnt1+1;
        else
            if (cnt1 < 8)
                SizeArray(cnt2,cnt1)=SizeArray(cnt2,cnt1)*10+NumaricLine(l);
            else
                if WriteFileName==1
                    FNames(cnt2,cnt3)=tline(l);
                    cnt3=cnt3+1;
                end
                if tline(l)=='/'
                    WriteFileName=1;
                end
            end
        end
    end
    tline = fgetl(fid);
    cnt2=cnt2+1;
    cnt3=1;
    WriteFileName=0;
end
fclose(fid);

if (size(unique(SizeArray(:,1)),1)~=size(SizeArray,1))
    [Value,Index]=unique(SizeArray(:,1));
    SizeArray=SizeArray(Index,:);
    FNames=FNames(Index,:);
end


if (SizeArray(end,1)>(size(unique(SizeArray(:,1)),1)-1))
    for i=0:SizeArray(end,1)
        if isempty(find(i==SizeArray(:,1)))
            fprintf('Video File Number %d is missing from the Size File\n',i);
        end
    end
    error('Missing files in the SizeArray or Size_File');
end

RateArray(:,[1,2])=(SizeArray(:,[3,4])./SizeArray(:,[2]))*FPS;
RateArray(:,[3,4])=(SizeArray(:,[6,7])./SizeArray(:,[5]))*FPS;
AvRateKbits=(sum(RateArray)/size(RateArray,1))/1000;
SavingGain=(1-(AvRateKbits(3)/AvRateKbits(1)))*100;
FrameNo=size(RateArray,1);
VideoRates=RateArray;

if ToPrint
    if (AvRateKbits(2) ~= AvRateKbits(4))
        error('Error in computing rate or motion information is not identical in Original and NoTexture Stats files');
    else
        fprintf('Number of Video files = %5d\n',size(RateArray,1));
        fprintf('Average Rate for Original Bitstream = %3.3f Kbps\n',AvRateKbits(1));
        fprintf('Average Rate for Notexture Bitstream = %3.3f Kbps\n',AvRateKbits(3));
        fprintf('Average Rate for Motion Informtion = %3.3f Kbps\n',AvRateKbits(2));
        fprintf('Saving Gain (No Texture / Original) = %3.3f%%\n',SavingGain);
    end
end