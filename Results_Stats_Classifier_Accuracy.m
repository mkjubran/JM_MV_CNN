close all;clear all;clc;

ToPrintRate=1;

%% Load the File Names [FNames] and Classification Decision Vector [Classified]
filename_Filename='Classifier/filenames_3D_A_QP51';
filename_Classifier='Classifier/correct_vec_3D_A_QP51';
[FNames_Classifier, Classified]=Correct_Vector_Load_Function(filename_Filename,filename_Classifier);
(sum(Classified)/length(Classified))*100;

%% Load the File Names [FNames], Associated Rates [AvRateKbits]
filename='Size_Orig_NOTexture_Test01_QP20_MVSR16_MVRes8_A.dat';
FPS=25;
[FNames_Rate ,FrameNo, VideoRates, AvRateKbits]=Rate_Load_Function(filename, FPS);
SavingGain=(1-(AvRateKbits(3)/AvRateKbits(1)))*100;
if ToPrintRate
    if (AvRateKbits(2) ~= AvRateKbits(4))
        error('Error in computing rate or motion information is not identical in Original and NoTexture Stats files');
    else
        fprintf('Number of Video files = %5d\n',FrameNo);
        fprintf('Average Rate for Original Bitstream = %3.3f Kbps\n',AvRateKbits(1));
        fprintf('Average Rate for Notexture Bitstream = %3.3f Kbps\n',AvRateKbits(3));
        fprintf('Average Rate for Motion Informtion = %3.3f Kbps\n',AvRateKbits(2));
        fprintf('Saving Gain (No Texture / Original) = %3.3f%%\n',SavingGain);
    end
end

%%Num_Rate_Classification = [(video number) (Rate Original) (Rate Motion) (Rate No Texture + first I) 
%%   (Rate Motion from No Texture File, same as previous Motion) 
%%   (Classification 0: not classified correctly, 1 clasified correctly)]
%% if the video numner is zero then we don't have the rate information of the video, doesn't meat it is not classified
for i=1:size(FNames_Rate,1)
    for j=1:size(FNames_Classifier,1)
        if strcmp(FNames_Rate(i,1:end-4),FNames_Classifier(j,7:2+length(FNames_Rate(i,:))));
            Num_Rate_Classification(i,:)=[i VideoRates(i,:)/1000 Classified(j)];
        end
    end
end
Num_Rate_Classification
Num_Rate_Classification(find(Num_Rate_Classification(:,1)==0),:)=[];
Num_Rate_Classification

