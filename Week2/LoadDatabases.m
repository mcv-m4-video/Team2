function [ highway, fall, traffic ] = LoadDatabases( cfg )
%LOADDATABASES Summary of this function goes here
%   Detailed explanation goes here

<<<<<<< HEAD
HWtrain = LoadImages(cfg.highway.inputPath, cfg.highway.trainFrames, 'in', 'jpg');
HWtest = LoadImages(cfg.highway.inputPath, cfg.highway.testFrames, 'in', 'jpg');
HWgt = LoadImages(cfg.highway.gtPath, cfg.highway.testFrames, 'gt', 'png');
HWseqName = 'highway';

Ftrain = LoadImages(cfg.fall.inputPath, cfg.fall.trainFrames, 'in', 'jpg');
Ftest = LoadImages(cfg.fall.inputPath, cfg.fall.testFrames, 'in', 'jpg');
Fgt = LoadImages(cfg.fall.gtPath, cfg.fall.testFrames, 'gt', 'png');
FseqName = 'fall';

Ttrain = LoadImages(cfg.traffic.inputPath, cfg.traffic.trainFrames, 'in', 'jpg');
Ttest = LoadImages(cfg.traffic.inputPath, cfg.traffic.testFrames, 'in', 'jpg');
Tgt = LoadImages(cfg.traffic.gtPath, cfg.traffic.testFrames, 'gt', 'png');
TseqName = 'traffic';
=======
highway.train = LoadImages(cfg.highway.inputPath, cfg.highway.trainFrames, 'in', 'jpg');
highway.test = LoadImages(cfg.highway.inputPath, cfg.highway.testFrames, 'in', 'jpg');
highway.gt = LoadImages(cfg.highway.gtPath, cfg.highway.testFrames, 'gt', 'png');
highway.seqName = 'highway';
highway.numTrainingFrames = length(cfg.highway.trainFrames);
highway.pathVideo = [cfg.pathToHighway 'video.avi'];

fall.train = LoadImages(cfg.fall.inputPath, cfg.fall.trainFrames, 'in', 'jpg');
fall.test = LoadImages(cfg.fall.inputPath, cfg.fall.testFrames, 'in', 'jpg');
fall.gt = LoadImages(cfg.fall.gtPath, cfg.fall.testFrames, 'gt', 'png');
fall.seqName = 'fall';
fall.numTrainingFrames = length(cfg.fall.trainFrames);
fall.pathVideo = [cfg.pathToFall 'video.avi'];

traffic.train = LoadImages(cfg.traffic.inputPath, cfg.traffic.trainFrames, 'in', 'jpg');
traffic.test = LoadImages(cfg.traffic.inputPath, cfg.traffic.testFrames, 'in', 'jpg');
traffic.gt = LoadImages(cfg.traffic.gtPath, cfg.traffic.testFrames, 'gt', 'png');
traffic.seqName = 'traffic';
traffic.numTrainingFrames = length(cfg.traffic.trainFrames);
traffic.pathVideo = [cfg.pathToTraffic 'video.avi'];
>>>>>>> 229aab6cc1ca716c723e5c108860b1b1184bcb8b

if cfg.grayscale
    highway.train = cellfun(@(c) double(rgb2gray(c)), HWtrain, 'UniformOutput', false);
    highway.test = cellfun(@(c) double(rgb2gray(c)), HWtest, 'UniformOutput', false);
    highway.gt = HWgt;
    highway.seqName = HWseqName;
    
    fall.train = cellfun(@(c) double(rgb2gray(c)), Ftrain, 'UniformOutput', false);
    fall.test = cellfun(@(c) double(rgb2gray(c)), Ftest, 'UniformOutput', false);
    
    traffic.train = cellfun(@(c) double(rgb2gray(c)), Ttrain, 'UniformOutput', false);
    traffic.test = cellfun(@(c) double(rgb2gray(c)), Ttest, 'UniformOutput', false);

elseif cfg.yuv
    [highway{1}.train, highway{2}.train, highway{3}.train] = obtainYUV(HWtrain);
    [highway{1}.test, highway{2}.test, highway{3}.test] = obtainYUV(HWtest);
    highway{1}.gt = HWgt; highway{2}.gt = HWgt; highway{3}.gt = HWgt;
    highway{1}.seqName = HWseqName; highway{2}.seqName = HWseqName; highway{3}.seqName = HWseqName;
    
    [fall{1}.train, fall{2}.train, fall{3}.train] = obtainYUV(Ftrain);
    [fall{1}.test, fall{2}.test, fall{3}.test] = obtainYUV(Ftest);
    fall{1}.gt = Fgt; fall{2}.gt = Fgt; fall{3}.gt = Fgt;
    fall{1}.seqName = FseqName; fall{2}.seqName = FseqName; fall{3}.seqName = FseqName;
    
    
    [traffic{1}.train, traffic{2}.train, traffic{3}.train] = obtainYUV(Ttrain);
    [traffic{1}.test, traffic{2}.test, traffic{3}.test] = obtainYUV(Ttest);
    traffic{1}.gt = Tgt; traffic{2}.gt = Tgt; traffic{3}.gt = Tgt;
    traffic{1}.seqName = TseqName; traffic{2}.seqName = TseqName; traffic{3}.seqName = TseqName;

end

end
function [Y, U, V] = obtainYUV (sequence)
    colorTrain = cellfun(@(c) double(rgb2yuv(c)), sequence, 'UniformOutput', false);
    %y
    Y = cellfun(@(c) c(:,:,1), colorTrain, 'UniformOutput', false);
    %u
    U = cellfun(@(c) c(:,:,2), colorTrain, 'UniformOutput', false);
    %v
    V = cellfun(@(c) c(:,:,3), colorTrain, 'UniformOutput', false);
    
end