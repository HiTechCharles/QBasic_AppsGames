10 KEY(1) ON: ON KEY(1) GOSUB 1690
20 CLS : KEY OFF: COLOR 9: LOCATE 4, 31
300 F$ = "MND11MLF12A12>D12F12A12>D12<"
310 F$ = F$ + "A12>F12D12<A12F12<"
320 F1$ = "MND12MLG12B-12>D12G12B-12"
330 F1$ = F1$ + ">E12<B-12>G12E12<B-12G12<"
340 F2$ = F2$ + "F#12D12A12F#12D12<A12<"
350 F2$ = "MNC12MLF#12A12>C12A12>D12"
360 F3$ = "MLC16<B-16A16G16F16E16D16"
370 F3$ = F3$ + "C#16<B16A16G#16B-16A16>"
380 F4$ = "D8MNC#8<A8A8A16>D16D#8MSE8"
390 F4$ = F4$ + "<A8A8MN>G8<MSA8A8"
400 F4A$ = "A16>MNF#32G32A8G8F8E8D8<A8"
410 F4A$ = F4A$ + "A8A16>E16G8"
420 F5$ = "MSF8<A8A8>MLA<D>MSB-8P4MN"
430 F5$ = F5$ + "A8.>D16MSC#12C12<B12MNB-"
440 F6$ = "MND8<<A8>>E8F#8<B8D#8E8>"
450 F6$ = F6$ + "C#16D#16E16F#16G16A16"
460 F7$ = "MSB8MNB8DMSC#8MNA8G#8>"
470 F5A$ = F5A$ + "D8<B8G#8>E8<"
480 F8$ = "MSD16<A16>C8A8A8A8MNA8."
490 F8$ = F8$ + "B32>C#32MSD8<"
500 F9$ = "MN<C16>MSA16MN<D16>MSG#16MN<"
510 F9$ = F9$ + "E16>MSG16MN<F16>MSF16<MN"
520 F10$ = "G#16MS>E16<MNA16>MSD#16<MNB16>D16"
530 F11$ = "MNA>F#8D8C#<B8>G16E16D8C#8B8A8A8.B32"
540 F12$ = "G32F#8A16F#16MSE8E8E8E8MN"
550 F12$ = F12$ + "E8MSA16P16MN<B8>MS"
560 PLAY "T180O1X" + VARPTR$(F$)
570 PLAY "X" + VARPTR$(F$)
580 PLAY "P64X" + VARPTR$(F1$)
590 PLAY "X" + VARPTR$(F1$)
600 PLAY "P64X" + VARPTR$(F2$)
610 PLAY "X" + VARPTR$(F2$)
620 PLAY "P64<B-12>MND12G12>G12A12G12<<MLA12"
630 PLAY "MN>C12F12>C12G12F12<<MLG12B-12>E-12"
640 PLAY "B-12>F12E-12<<G#12MNB12ML>F12B12>"
650 PLAY "E12D12<<A12>MNC#12E12A12>C#12E12"
660 PLAY "A12>C#12E12A12>C#12E12D#12E12C12"
670 PLAY "C#12P64ML<G#12MNA12MLT170D#12MN"
680 PLAY "E12C12T160C#12<G#12A12ML<<<A2P4."
690 PLAY "T95O3MNF8<MSA8A8A16>MNE32F32MSG8F8E8"
700 PLAY "X" + VARPTR$(F4$)
710 PLAY "X" + VARPTR$(F4A$)
720 PLAY "X" + VARPTR$(F5$)
730 PLAY "P8.MSA16MNA8MSG#8MNC#8G8D8F#8<B8"
740 PLAY ">F8<A8>E8A8>C#8E8P4<<T105E8E8E8E8"
750 PLAY "E8E8<A8>E8<G#8>E8<G8>E8<F#8>D#8MS"
760 PLAY "A8A8MNA.G#32A32B32A32G#P8."
770 PLAY "B12T110MLA16G#16MNF16MLB16MNA16G16"
780 PLAY "F16B-16MLA16G#16MNF16MLB16MNF16>"
790 PLAY "D16<F16G16MLB16A16MNE16ML>C16<B16"
800 PLAY "A16MNE16ML>C16MN<B16A16E16>C16<E16"
810 PLAY ">E16<E16A16>T120C16<B16MLE16>D16"
820 PLAY "MNC16<B16MLE16>D16C16<B-16MNE16>"
830 PLAY "D16<E16>F16<E16"
840 PLAY "B-16>MLD16C16T130X" + VARPTR$(F9$)
850 PLAY "X" + VARPTR$(F10$)
860 PLAY "C16E16T140X" + VARPTR$(F9$)
870 PLAY "X" + VARPTR$(F10$)
880 PLAY "P4T160MNC8<C8C8C16MLB32>C32MND8"
890 PLAY "C8<B-8A8MLG#8MNE8E8E16A16MLA#8"
900 PLAY "MNB8E8E8>F8<D8D8D16>E32F32G8F8"
910 PLAY "E8D8MLC#8<MNE8E8E16>D16MLD#8MN"
920 PLAY "E8<T170C8C16>F16P64F#8MSG8<C8"
930 PLAY "C16>A16>C8MN<B-8P4T190MLA16>C16"
940 PLAY "<B-16A16G16F16E16D16C#16E16<A16>"
950 PLAY "C16<B-16A16G16F16E16D16C#16E16<"
960 PLAY "A16>C16<B-16A16G16F16E16D16C#16"
970 PLAY "E16<A16>C16<B-16A16G16C16E-16F#16"
980 PLAY "A16>C16E-16F#16A16>C16E-16F#16A16"
990 PLAY ">C16E-16F#16A16>C16E-8P4MNT170O2D8"
1000 PLAY "D8D8D8D8D8<G8>D8<F#8>D8<F8>D8<E8>"
1010 PLAY "C#8G8G8MLG.P32F#32G32A32G32MNF#P8."
1020 PLAY "MLO3A16MNG16F#16MLE16A16MNG16F#16"
1030 PLAY "MLE16A16G16F#16E16A16E16>C16<E16"
1040 PLAY "F#16MNA16G16MLD16B-16MNA16G16MLD16"
1050 PLAY "B-16MNA16G16MLD16B-16D16>D16<D16G16"
1060 PLAY "MNB-16A16MLD16>C16<MNB-16A16MLD16>"
1070 PLAY "C16<MNB-16A16MLD16>C16<D16>E-16<"
1080 PLAY "D16A16>C16<B-16<B-16>>MSG16<MNC16"
1090 PLAY ">MSF#16<MND16>MSF16<MNE-16>MSE-16<"
1100 PLAY "MNF#16>MSD16<MNG16>MSC#16<MLA16>MN"
1110 PLAY "C16<MLB-16>D16<<B-16>>MSG16<MNC16>"
1120 PLAY "MSF#16<MND16>MSF16MND16E-16<D-16>"
1130 PLAY "MSE16MNG16F#16<E-16>MSF#16MNA16G16"
1140 PLAY "<D16>MSA16>C16<B-16<<G#16>>B16>D16"
1150 PLAY "C#16<<B-16>>MND16F8E8.P4T190MLD#16"
1160 PLAY "E16D16C#16<B16A16G#16B-16A16P64>"
1170 PLAY "X" + VARPTR$(F3$)
1180 PLAY "X" + VARPTR$(F3$)
1190 PLAY "X" + VARPTR$(F3$)
1200 PLAY "C16<B-16A16G16F16E16D16<T170A2T190"
1210 PLAY "P16>A.MNB16A16G#16A8MLB-32B32>C32"
1220 PLAY "C#32D32E-32E32F32F#32G32G#32A32B-32"
1230 PLAY "B32>C32C#32D32E-32E32F32F#32G32G#32"
1240 PLAY "A32B-32B32>C32C#32D32D#32E32FT170O3"
1250 PLAY "MNF8<MSA8A8A16>MNE32F32MSG8F8E8"
1260 PLAY "X" + VARPTR$(F4$)
1270 PLAY "X" + VARPTR$(F4A$)
1280 PLAY "X" + VARPTR$(F5$)
1290 PLAY "P8.MSA16MNA8MSG#8P8.G16>E8<G8P8."
1300 PLAY "G16MNE8MSF8P8.F16MLE-E-8MNF32E32"
1310 PLAY "D32E32F16G8A32G32F#32G32A16MSB-8"
1320 PLAY "MNP8<<<G#32B32>D32F32G#32B32>D32"
1330 PLAY "F32G#32B32>D32F32G#32"
1340 PLAY "B32>D32F16P8<A8P4.<C#8P4.T160"
1350 PLAY "X" + VARPTR$(F11$)
1360 PLAY "X" + VARPTR$(F12$)
1370 PLAY "F#16MNP16<A>C#8.<B16AP4"
1380 PLAY "X" + VARPTR$(F11$)
1390 PLAY "X" + VARPTR$(F12$)
1400 PLAY "F#16MNP16<A>C#8.<B16AP4>"
1410 PLAY "X" + VARPTR$(F6$)
1420 PLAY "X" + VARPTR$(F7$)
1430 PLAY "G8F#8B8DF#8.E16MLDMNP4"
1440 PLAY "X" + VARPTR$(F6$)
1450 PLAY "X" + VARPTR$(F7$)
1460 PLAY "G8F#8B8DF#8.E16MLD16MN<A16F#16"
1470 PLAY "A16F#16A16>X" + VARPTR$(F8$)
1480 PLAY "X" + VARPTR$(F8$) + "MND8>MSC8C8"
1490 PLAY "C8C8MNC16<B16MLA#16B16A16G16"
1500 PLAY "F#16E16MNDF#8.E16D16<A16F#16"
1510 PLAY "A16F#16A16>X" + VARPTR$(F8$)
1520 PLAY "X" + VARPTR$(F8$) + "MSD8>MNC2MS<B"
1530 PLAY "P4>DP4<<<A2.T180B32A32G#32MNA32"
1540 PLAY "B32>C#32D32E32F#32G32A32B32>C#32"
1550 PLAY "D32E32F#32G32A32B32>C#32D32C#32E32"
1560 PLAY "D32C#32<B32A32>C#32<B32A32G32F#32"
1570 PLAY "A32G32F#32E32D#32E32F#32E32G32A32"
1580 PLAY "G32F#32E32D#32E32F#32E32G32E32E32"
1590 PLAY "D32E32D32E32D32E32D#32E32F#32E32"
1600 PLAY "G32F#32A32G32F#32E32G32F#32E32D32"
1610 PLAY "F#16E16D16C#16E8D8C#8<B8T170A>F#8"
1620 PLAY "D8C#<B8>G16E16D8C#8B8A8A8.B32G32F#8"
1630 PLAY "A16F#16>MSD8D8D8D8<BP8MNG16E16MSC#8"
1640 PLAY "C#8C#8C#8DP4BP4AP4<C#P4.T160<MNAF#8"
1650 PLAY "D8C#<B8>G16E16D8C#8B8T150A8A8.F#16A"
1660 PLAY "P8A>T140F#8D8<B.>G16E16C#16D16E16"
1670 PLAY "F#16G16A16B16>C#16T100MSDP8<A8P8"
1680 PLAY "F#8P8T90C#8P8DP4"
1690 CLS : COLOR 7, 0: KEY ON

