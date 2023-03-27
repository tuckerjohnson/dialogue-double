Server.default.options.numOutputBusChannels_(7);
Server.default.options.memSize_(2.pow(20));


~one_lev = 1.1;
~two_lev = 1;
~thr_lev = 1;
~fou_lev = 1;
~fiv_lev = 1;
~six_lev = 1;

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
		{~sigle_one = Synth.new(\playback, [\buf, b[0], \out, ~hex_bus, \amp, ~one_lev], ~playback)},
		{ b[0].postln }
	)
};, '/2/button9' );

OSCdef.new(\10, { arg msg, time, addr, port;
	if( msg[1] == 1.0,
		{~tran_one = Synth.new(\playback, [\buf, b[1], \out, ~hex_bus, \amp, ~two_lev], ~playback)},
		{ b[0].postln }
	)
};, '/2/button10' );

OSCdef.new(\11, { arg msg, time, addr, port;
	if( msg[1] == 1.0,
		{~tran_two = Synth.new(\playback, [\buf, b[2], \out, ~hex_bus, \amp, ~thr_lev], ~playback)},
		{ b[0].postln }
	)
};, '/2/button11' );

OSCdef.new(\12, { arg msg, time, addr, port;
	if( msg[1] == 1.0,
		{~tran_thr = Synth.new(\playback, [\buf, b[3], \out, ~hex_bus, \amp, ~fou_lev], ~playback)},
		{ b[0].postln }
	)
};, '/2/button12' );
OSCdef.new(\13, { arg msg, time, addr, port;
	if( msg[1] == 1.0,
		{~tranfou_ = Synth.new(\playback, [\buf, b[4], \out, ~hex_bus, \amp, ~fiv_lev], ~playback)},
		{ b[0].postln }
	)
};, '/2/button13' );

OSCdef.new(\14, { arg msg, time, addr, port;
	if( msg[1] == 1.0,
		{~sigle_two = Synth.new(\playback, [\buf, b[5], \out, ~hex_bus, \amp, ~six_lev], ~playback)},
		{ b[0].postln }
	)
};, '/2/button14' );


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

OSCdef.new(\26, { arg msg, time, addr, port;
	~one_lev = msg[1];
	("1_lev"+msg[1]).postln;
	~sigle_one.set(\amp, msg[1]);
};, '/fader26' );

OSCdef.new(\25, { arg msg, time, addr, port;
	~two_lev = msg[1];
	("2_lev"+msg[1]).postln;
	~tran_one.set(\amp, msg[1]);
};, '/fader25' );

OSCdef.new(\24, { arg msg, time, addr, port;
	~thr_lev = msg[1];
	("3_lev"+msg[1]).postln;
	~tran_two.set(\amp, msg[1]);
};, '/fader24' );

OSCdef.new(\23, { arg msg, time, addr, port;
	~fou_lev = msg[1];
	("4_lev"+msg[1]).postln;
	~tran_thr.set(\amp, msg[1]);
};, '/fader23' );

OSCdef.new(\22, { arg msg, time, addr, port;
	~fiv_lev = msg[1];
	("5_lev"+msg[1]).postln;
	~tran_fou.set(\amp, msg[1]);
};, '/fader22' );

OSCdef.new(\21, { arg msg, time, addr, port;
	~six_lev = msg[1];
	("6_lev"+msg[1]).postln;
	~sigle_two.set(\amp, msg[1]);
};, '/fader21' );
