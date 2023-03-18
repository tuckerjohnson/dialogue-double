SynthDef.new(\playback,
	{
		arg buf, out, start;
		var a, b, c, d, e, f, g;
		#a, b, c, d, e, f, g = PlayBuf.ar(7, buf, BufRateScale.kr(buf), 1, start, 0, 2);
		Out.ar(out, [a, b, c, d, e, f, g]);
	}
).add;

SynthDef.new(\stereo,
	{
		arg in, out=0, amp=0.5, amp_os=0.1;
		var a, b, c, d, e, f, g, mix;
		#a, b, c, d, e, f, g = amp * In.ar(in, 7);
		g = g * amp_os;
		mix = Mix.new(
			[
				Pan2.ar(a, -0.2),
				Pan2.ar(b, 0.2),
				Pan2.ar(c, 0.6),
				Pan2.ar(d, 1),
				Pan2.ar(e, -1),
				Pan2.ar(f, -0.6),
				Pan2.ar(g, 0)
			]
		);
		Out.ar(out, mix);
	}
).add;