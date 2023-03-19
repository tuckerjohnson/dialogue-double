Server.default.options.numOutputBusChannels_(7);
Server.default.options.memSize_(2.pow(20));





(".tools/defs.scd").loadRelative;


s.waitForBoot({

	PathName(thisProcess.nowExecutingPath.dirname +/+ "audio").entries.do({ arg path, i;
			b = b.add(Buffer.readChannel(s, path.fullPath));
		});

	~playback = Group.new(s.defaultGroup);
	~hex_bus = Bus.audio(s, 7);
	~out = Synth.new(\stereo, [\in, ~hex_bus], s.defaultGroup, \addToTail);
	//~out = Synth.new(\hex, [\in, ~hex_bus], s.defaultGroup, \addToTail);
});
OSCdef.new(\9, { arg msg, time, addr, port;
	if( msg[1] == 1.0,
		{~sigle_one = Synth.new(\playback, [\buf, b[0], \out, ~hex_bus], ~playback)},
		{ b[0].postln }
	)
};, '/2/button9' );

OSCdef.new(\10, { arg msg, time, addr, port;
	msg.postln;
};, '/2/button10' );

OSCdef.new(\11, { arg msg, time, addr, port;
	msg.postln;
};, '/2/button11' );

OSCdef.new(\12, { arg msg, time, addr, port;
	msg.postln;
};, '/2/button12' );
OSCdef.new(\13, { arg msg, time, addr, port;
	msg.postln;
};, '/2/button13' );

OSCdef.new(\14, { arg msg, time, addr, port;
	msg.postln;
};, '/2/button14' );

OSCdef.new(\15, { arg msg, time, addr, port;
	msg.postln;
};, '/2/button15' );

OSCdef.new(\19, { arg msg, time, addr, port;
	if( msg[1] == 1.0,
		{ s.defaultGroup.dumpTree },
		{ ~nib = 0 }
	)
};, '/button19' );

OSCdef.new(\20, { arg msg, time, addr, port;
	if( msg[1] == 1.0,
		{ ~playback.freeAll; },
		{ ~nib = 0 }
	)
};, '/button20' );
