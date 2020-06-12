clear all;

%---Parameters to tweak---
 
    %Supports: Motion JPEG 2000, Archival, Motion JPEG AVI, Uncompressed AVI, MPEG-4, Grayscale AVI, Indexed AVI
    fileDirectory = 'D:\test_data_07\phantom_test8.avi';

    %Amount of frames in the recording
    framecount = 20; 

    %Framerate in Hz, set b/w 30 and 230
    framerate = 200;

    %Exposure time of individual frames (microseconds), set b/w 5 and 9999 
    exposure = 4500; 



%--code--

vid1 = videoinput('gentl', 1, 'Mono8');
src1 = getselectedsource(vid1);


%parameters
src1.AcquisitionFrameRate = framerate; 
src1.ExposureTime = exposure;
vid1.FramesPerTrigger = framecount;
src1.Banks = 'Banks_A'; %chrashes if 'Bank_ABCD'




vid1.LoggingMode = 'disk&memory'; %'memory', 'disk' or 'disk&memory'
logfile = VideoWriter(fileDirectory);
vid1.DiskLogger = logfile;

pause(5);

disp('starting acquisition')
start(vid1);
wait(vid1,framecount/50+5);
stop(vid1);



%debug
frames_acquired = vid1.FramesAcquired
frames_to_disk = vid1.DiskLoggerFrameCount

[frames, timeStamp] = getdata(vid1);
avg_frame_rate = (framecount-1)/(timeStamp(end)-timeStamp(1))

