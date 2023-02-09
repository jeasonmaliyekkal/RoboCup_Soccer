function pos = ObjectTracking(scene)

addpath('.\Tracking\')

%% Load frame

%frame = imread('..\Soccerfield_org.jpg');

frame = scene.cdata;

 %% Ball Tracking
mskBall = createMaskYellow(frame);
noiseMask = strel('square', 2);
imOpenOut = imopen(mskBall, noiseMask);
blobObj = vision.BlobAnalysis();
[ areaBall,centroidBall,bboxBall] = step(blobObj, imOpenOut);
%bshape = insertShape(frame, 'rectangle', bboxBall, 'LineWidth', 2, 'Color',[0,0,0]);
%imshowpair(bshape, imOpenOut,"montage");

%% Red Player Tracking
mskRed = createMaskRed(frame);
[ areaRed,centroidRed, bboxRed] = step(blobObj, mskRed);
%bshape = insertShape(bshape, 'rectangle', bboxRed, 'LineWidth', 2, 'Color',[0,0,0]);
%imshowpair(bshape, mskRed,"montage");

%% Blue Player Tracking
%mskBlue = createMaskBlue(frame);
%[ areaBlue,centroidBlue, bboxBlue] = step(blobObj, mskBlue);
%bshape = insertShape(bshape, 'rectangle', bboxBlue, 'LineWidth', 2, 'Color',[0,0,0]);
%imshowpair(bshape, mskBlue,"montage");
%imshow(bshape)


pos = [centroidBall,centroidRed(1,:),centroidRed(2,:),centroidRed(3,:),centroidRed(4,:)];
%imshow(frame);
end