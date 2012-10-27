%%
%% Propeller for Swedish Navy 20m MTB.
%%
%% Known: Diameter 0.7 m(?), pitch ??, diameter of hub ??.
%%        Engine power 1500 hp @ 2000 rpm.
%%        Max speed 50 knots.
%%

%% Assumed properties of seawater
%%   density:             1027.68 kg/m^3
%%   kinematic Viscosity: 0.00000183 m^2/s
%%   speed of sound:      1560 m/s


%% JavaProp parameters.
%%
%%   Diameter                0.7 m
%%   Spinner Dia.  Dsp       0.15 m
%%   Speed of Rotation       2000 1/min
%%   Velocity                25.00 m/s
%%   Number of Blades        4
%%   Power  P                1118.550 kW
%%

JP = [
%v/(nD)	v/(ΩR)	Ct	Cp	Cs	Pc	η	η*	stalled	v	n	Power	Thrust	Torque
%[-]	[-]	[-]	[-]	[-]	[-]	[%]	[%]	[%]	[m/s]	[1/min]	[kW]	[kN]	[kNm]

0.000	0.000	0.542929	0.830371	0.000033	999999.000000	0.00	0.00	97.00 	0.00	90	447.395	71.091	47.470
0.100	0.032	0.408513	0.628901	0.109719	1601.482225	6.50	16.84	97.00 	0.41	90	338.845	53.490	35.953
0.200	0.064	0.536437	0.896767	0.204406	285.449650	11.96	26.87	97.00 	0.82	90	483.168	70.241	51.266
0.300	0.095	0.527551	0.908400	0.305820	85.674850	17.42	37.35	87.00 	1.23	90	489.436	69.077	51.931
0.400	0.127	0.520215	0.909786	0.407636	36.199226	22.87	46.11	78.00 	1.65	90	490.183	68.117	52.010
0.500	0.159	0.531720	0.878785	0.513090	17.902451	30.25	52.73	47.00 	2.06	90	473.480	69.623	50.238
0.600	0.191	0.537297	0.855931	0.618961	10.090787	37.66	58.33	23.00	2.47	90	461.166	70.353	48.931
0.700	0.223	0.523208	0.832484	0.726144	6.180475	43.99	63.68	8.00	2.88	90	448.534	68.509	47.591
0.800	0.255	0.494197	0.797426	0.837051	3.966072	49.58	68.78	0.00	3.29	90	429.645	64.710	45.587
0.900	0.286	0.454265	0.751421	0.952941	2.624799	54.41	73.60	0.00	3.70	90	404.858	59.481	42.957
1.000	0.318	0.411308	0.698123	1.074518	1.777755	58.92	77.91	0.00	4.11	90	376.141	53.856	39.910
1.100	0.350	0.353507	0.619557	1.210533	1.185340	62.76	82.25	0.00	4.53	90	333.811	46.288	35.418
1.200	0.382	0.316077	0.567832	1.343808	0.836790	66.80	85.32	0.00	4.94	90	305.942	41.387	32.461
1.300	0.414	0.263250	0.489811	1.499469	0.567726	69.87	88.55	0.00	5.35	90	263.905	34.470	28.001
1.400	0.446	0.208059	0.404642	1.677698	0.375515	71.99	91.50	0.00	5.76	90	218.017	27.243	23.132
1.500	0.477	0.140853	0.296678	1.912645	0.223847	71.22	94.55	0.00	6.17	90	159.847	18.443	16.960
1.520	0.484	0.137415	0.291128	1.945480	0.211102	71.75	94.77	0.00	6.25	90	156.857	17.993	16.643
1.620	0.516	0.072248	0.182725	2.275913	0.109444	64.05	97.39	0.00	6.67	90	98.450	9.460	10.446
1.640	0.522	0.059477	0.161155	2.362626	0.093036	60.53	97.87	0.00	6.75	90	86.829	7.788	9.213
1.660	0.528	0.045366	0.137170	2.469768	0.076362	54.90	98.39	0.00	6.83	90	73.906	5.940	7.842
1.680	0.535	0.031919	0.114259	2.592573	0.061363	46.93	98.88	0.00	6.91	90	61.562	4.179	6.532
1.700	0.541	0.018124	0.090676	2.747578	0.046999	33.98	99.37	0.00	7.00	90	48.855	2.373	5.184
1.720	0.547	0.004887	0.067995	2.944648	0.034027	12.36	99.83	0.00	7.08	90	36.635	0.640	3.887
1.740	0.554	-0.007266	0.047141	3.205304	0.022787	0.00	99.99	0.00	7.16	90	25.399	-0.951	2.695
1.760	0.560	-0.018899	0.027235	3.618153	0.012721	0.00	99.99	0.00	7.24	90	14.674	-2.475	1.557
1.780	0.567	-0.032417	0.004221	5.313007	0.001906	0.00	99.99	0.00	7.32	90	2.274	-4.245	0.241
1.800	0.573	-0.045958	-0.018848	3.983088	-0.008230	0.82	48.48	0.00	7.41	90	-10.155	-6.018	-1.077
];

C_Thrust1 = [JP(:,1) JP(:,3)];

C_Power1 = [JP(:,1) JP(:,4)];

Efficiency = C_Thrust1(:,1) .* C_Thrust1(:,2) ./ C_Power1(:,2);

%% Thrust and Power v.s. advance ratio.

figure();
axis();
plot(C_Thrust1(:,1), C_Thrust1(:,2),\
     C_Power1(:,1), C_Power1(:,2));

%% Efficiency v.s. advance ratio.
figure();
axis([0 1 0 1]);
plot(C_Thrust1(:,1), Efficiency);

Advance = 0:0.05:2.00;

C_Thrust = [Advance' \
            interp1(C_Thrust1(:,1),C_Thrust1(:,2), Advance, 'extrap')'];

C_Power = [Advance' \
           interp1(C_Power1(:,1),C_Power1(:,2), Advance, 0.01)'];

figure();
plot(Advance, C_Thrust(:,2), Advance, C_Power(:,2));