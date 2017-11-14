close all;clear all;clc;

%jmmv="jmmv.bin";
jmmv="jmmv_NoText.bin";
avmv="jmmv_ffmpeg.bin";
%jmmv="jmmv_ffmpeg_Abbas.bin";
%avmv="avmv.bin";
play=1;

[av_mv_data] = load_mv(avmv, 10, 0) ;
[jm_mv_data] = load_mv(jmmv, 10, 0) ;

numFrame = min(size(jm_mv_data,3), size(av_mv_data,3)) ;

jmdx = jm_mv_data(1:end/2, :, 1:numFrame) ;
jmdy = jm_mv_data((end/2)+1:end, :, 1:numFrame) ;

avdx = av_mv_data(1:end/2, :, 1:numFrame) ;
avdy = av_mv_data((end/2)+1:end, :, 1:numFrame) ;

sqdiff_dx = avdx - jmdx ;
sqdiff_dx = sqdiff_dx.^2 ;

sqdiff_dy = avdy - jmdy ;
sqdiff_dy = sqdiff_dy.^2 ;

sumsqdiff = sqdiff_dx + sqdiff_dy ;
for i=1:numFrame
    epe(i) = mean(mean(sumsqdiff(:,:,i)));
end

epe_av=mean(epe)

Tjm=max(max(max(sqrt(jmdx.^2+jmdy.^2))))
Tav=max(max(max(sqrt(avdx.^2+avdy.^2))))

plot(1:numFrame,epe);

if play
    implay(10*(sqrt(jmdx.^2+jmdy.^2))/Tjm);
    implay(10*(sqrt(avdx.^2+avdy.^2))/Tav);
end