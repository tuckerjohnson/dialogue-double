Server.default.options.numOutputBusChannels_(7);
Server.default.options.memSize_(2.pow(20));





(".tools/defs.scd").loadRelative;


s.waitForBoot({

	PathName(thisProcess.nowExecutingPath.dirname +/+ "audio").entries.do({ arg path, i;
			b = b.add(Buffer.readChannel(s, path.fullPath));
		});

	~hex_bus = Bus.audio(s, 7);
	