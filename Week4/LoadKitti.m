function [ kitti ] = LoadKitti( cfg )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

seq= cfg.kittiSequences;
for i = 1: length(seq)
    
   currentPath = sprintf ( '%s%06d_%02d.%s', cfg.kitti.inputPath, seq(i), 11, 'png');
   kitti{i}.current = imread(currentPath);
   
   refPath = sprintf ( '%s%06d_%02d.%s', cfg.kitti.inputPath, seq(i), 10, 'png');
   kitti{i}.reference = imread(refPath);
   
   gtPath = sprintf ( '%s%06d_%02d.%s', cfg.kitti.inputPath, seq(i), 10, 'png');
   kitti{i}.gt = imread(gtPath);
    
end
end

