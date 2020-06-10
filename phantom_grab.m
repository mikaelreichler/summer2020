
%---Parameters to tweak---
 
%Supports: Motion JPEG 2000, Archival, Motion JPEG AVI, Uncompressed AVI, MPEG-4, Grayscale AVI, Indexed AVI
filename = 'phantom_30fps_test.avi'

%Amount of frames in the recording, (f/r currently 30 fps)
framecount = 100 

%Exposure time of individual frames (microseconds), set b/w 5 and 9999 
exposure = 6000 



%--code--

vid1 = videoinput('gentl', 1, 'Mono8');
src1 = getselectedsource(vid1);


%parameters
src1.AcquisitionFrameRate = 80; %hz
src1.ExposureTime = exposure;
vid1.FramesPerTrigger = framecount;
src1.Banks = 'Banks_A';



vid1.LoggingMode = 'disk&memory'; %'memory', 'disk' or 'disk&memory'
logfile = VideoWriter(filename);
vid1.DiskLogger = logfile;


start(vid1);
wait(vid1,5);

%debug
frames_acquired = vid1.FramesAcquired
frames_to_disk = vid1.DiskLoggerFrameCount



% vid2 = videoinput('gentl', 2, 'Mono8');
% src2 = getselectedsource(vid2);
% 
% vid2.FramesPerTrigger = 1;
% 
% vid3 = videoinput('gentl', 3, 'Mono8');
% src3 = getselectedsource(vid3);
% 
% vid3.FramesPerTrigger = 1;
% 
% vid4 = videoinput('gentl', 4, 'Mono8');
% src4 = getselectedsource(vid4);
% 
% vid4.FramesPerTrigger = 1;
