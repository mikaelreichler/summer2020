var grabber = grabbers[0];
var FPS = 4000;
// camera configuration
grabber.RemotePort.set("Banks", "Banks_A");
grabber.RemotePort.set("Width", "1024");
grabber.RemotePort.set("Height", "512");
grabber.RemotePort.set("AcquisitionFrameRate", FPS);
grabber.RemotePort.set("ExposureTime", 1e6 / FPS - 1);
grabber.RemotePort.set("ShutterMode", "Rolling");


// frame grabber configuration
grabber.DevicePort.set("CameraControlMethod", "RG");
grabber.DevicePort.set("CycleTriggerSource", "Immediate");
grabber.DevicePort.set("CycleMinimumPeriod", 1e6 / FPS);
