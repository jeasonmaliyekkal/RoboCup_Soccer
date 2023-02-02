clc;
clear;

%% Variable 'vidIn' takes the input video/simulation to process for players/ball
%% centroidBall, centroidRed(red team players), centroidBlue(blue team players) outputs matrices with the corresponding centroid positions
  
  
vidIn = VideoReader('D:\MSc\TDP\Data\MultiPlayer.mp4');

while hasFrame(vidIn)
    frame = readFrame(vidIn);

    %% Ball Tracking
    mskBall = createMaskYellow(frame);
    noiseMask = strel('square', 2);
    imOpenOut = imopen(mskBall, noiseMask);
    blobObj = vision.BlobAnalysis();
    [ areaBall,centroidBall,bboxBall] = step(blobObj, imOpenOut);
    bshape = insertShape(frame, 'rectangle', bboxBall, 'LineWidth', 2, 'Color',[0,0,0]);
   %imshowpair(bshape, imOpenOut,"montage");

    %% Red Player Tracking
    mskRed = createMaskRed(frame);
    [ areaRed,centroidRed, bboxRed] = step(blobObj, mskRed);
    bshape = insertShape(bshape, 'rectangle', bboxRed, 'LineWidth', 2, 'Color',[0,0,0]);
    %imshowpair(bshape, mskRed,"montage");

    %% Blue Player Tracking
    mskBlue = createMaskBlue(frame);
    [ areaBlue,centroidBlue, bboxBlue] = step(blobObj, mskBlue);
    bshape = insertShape(bshape, 'rectangle', bboxBlue, 'LineWidth', 2, 'Color',[0,0,0]);
%   imshowpair(bshape, mskBlue,"montage");
    imshow(bshape)
    
   
end



