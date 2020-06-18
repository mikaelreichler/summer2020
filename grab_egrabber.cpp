#include <tools.h>
#include <iostream>
#include <EGrabber.h>
#include <FormatConverter.h>

using namespace Euresys;

int framecount = 500;

static void sample() {
	EGenTL genTL; 
	EGrabber<CallbackOnDemand> grabber(genTL); // create grabber
	FormatConverter converter(genTL); 

	grabber.runScript("config.js");

	grabber.reallocBuffers(2); 
	
	std::cout << "starting" << std::endl;
	grabber.start(framecount); 

	for (size_t frame = 0; frame < framecount; ++frame) {
		ScopedBuffer buffer(grabber); // wait and get a buffer
		// Note: ScopedBuffer pushes the buffer back to the input queue automatically
		uint8_t* imagePointer = buffer.getInfo<uint8_t*>(gc::BUFFER_INFO_BASE);
		void* ptr = buffer.getInfo<void*>(GenTL::BUFFER_INFO_BASE);
		FormatConverter::Auto bgr(converter, FormatConverter::OutputFormat("BGR8"), imagePointer,
			buffer.getInfo<uint64_t>(gc::BUFFER_INFO_PIXELFORMAT),
			buffer.getInfo<size_t>(gc::BUFFER_INFO_WIDTH),
			buffer.getInfo<size_t>(gc::BUFFER_INFO_DELIVERED_IMAGEHEIGHT),
			buffer.getInfo<size_t>(gc::BUFFER_INFO_SIZE),
			buffer.getInfo<size_t>(ge::BUFFER_INFO_CUSTOM_LINE_PITCH));
		
		std::cout << ptr << std::endl;	 
		
		bgr.saveToDisk("frame.NNN.png", frame);
	}
}

int main() {
	try {
		sample();
	}
	catch (const std::exception& e) {
		std::cout << "error: " << e.what() << std::endl;
	}
}
