log using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\logs-replicate-study\0-clean-data\3-eclsk-merge-3.log", replace

/**********************
READ .DAT GEOCODE FILES
**********************/

// Child 1

infix str childid 1-8 ///
	  s_id1 9-12 ///
	  roundnm1 13 ///
	  dispcde1 14 ///
	  str tract1 15-25 ///
	  zcta1 26-30 ///
	  rzip1 31-35 ///
	  using "C:\Users\wodtke\Desktop\ecls_k98\restricted\ECLS-K Census Data and Geocodes\child1.dat", clear

label define dispcde1_labels ///
	  1 "Matched Automatically" ///
	  2 "Edited Address or Placed" ///
	  3 "PO Box" ///
	  4 "Rural Route" ///
	  5 "Only Matched to Zip" ///
	  6 "Not Matched" ///
	  7 "No Address" ///
	  8 "Address in Mexico"
label values dispcde1 dispcde1_labels

save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Restricted\Geocode\child1.dta", replace

// Child 2

infix str childid 1-8 ///
	  s_id2 9-12 ///
	  roundnm2 13 ///
	  dispcde2 14 ///
	  str tract2 15-25 ///
	  zcta2 26-30 ///
	  rzip2 31-35 ///
	  using "C:\Users\wodtke\Desktop\ecls_k98\restricted\ECLS-K Census Data and Geocodes\child2.dat", clear

label define dispcde2_labels ///
	  1 "Matched Automatically" ///
	  2 "Edited Address or Placed" ///
	  3 "PO Box" ///
	  4 "Rural Route" ///
	  5 "Only Matched to Zip" ///
	  6 "Not Matched" ///
	  7 "No Address" ///
	  8 "Address in Mexico"
label values dispcde2 dispcde2_labels

// one childid has duplicate
duplicates list childid
list if childid == "0192003C"

// I'm removing the observation which has dispcde2 == "Rural Route" and keeping
// the observation which has dispcde2 == "PO Box"
drop if childid == "0192003C" & dispcde2 == 4

save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Restricted\Geocode\child2.dta", replace

// Child 3

infix str childid 1-8 ///
	  s_id3 9-12 ///
	  roundnm3 13 ///
	  dispcde3 14 ///
	  str tract3 15-25 ///
	  zcta3 26-30 ///
	  rzip3 31-35 ///
	  using "C:\Users\wodtke\Desktop\ecls_k98\restricted\ECLS-K Census Data and Geocodes\child3.dat", clear

label define dispcde3_labels ///
	  1 "Matched Automatically" ///
	  2 "Edited Address or Placed" ///
	  3 "PO Box" ///
	  4 "Rural Route" ///
	  5 "Only Matched to Zip" ///
	  6 "Not Matched" ///
	  7 "No Address" ///
	  8 "Address in Mexico"
label values dispcde3 dispcde3_labels

save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Restricted\Geocode\child3.dta", replace

// Child 4

infix str childid 1-8 ///
	  s_id4 9-12 ///
	  roundnm4 13 ///
	  dispcde4 14 ///
	  str tract4 15-25 ///
	  zcta4 26-30 ///
	  rzip4 31-35 ///
	  using "C:\Users\wodtke\Desktop\ecls_k98\restricted\ECLS-K Census Data and Geocodes\child4.dat", clear

label define dispcde4_labels ///
	  1 "Matched Automatically" ///
	  2 "Edited Address or Placed" ///
	  3 "PO Box" ///
	  4 "Rural Route" ///
	  5 "Only Matched to Zip" ///
	  6 "Not Matched" ///
	  7 "No Address" ///
	  8 "Address in Mexico"
label values dispcde4 dispcde4_labels

save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Restricted\Geocode\child4.dta", replace

// Child 5

infix str childid 1-8 ///
	  s_id5 9-12 ///
	  roundnm5 13 ///
	  dispcde5 14 ///
	  str tract5 15-25 ///
	  zcta5 26-30 ///
	  rzip5 31-35 ///
	  using "C:\Users\wodtke\Desktop\ecls_k98\restricted\ECLS-K Census Data and Geocodes\child5.dat", clear

label define dispcde5_labels ///
	  1 "Matched Automatically" ///
	  2 "Edited Address or Placed" ///
	  3 "PO Box" ///
	  4 "Rural Route" ///
	  5 "Only Matched to Zip" ///
	  6 "Not Matched" ///
	  7 "No Address" ///
	  8 "Address in Mexico"
label values dispcde5 dispcde5_labels

save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Restricted\Geocode\child5.dta", replace

// Child All

use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Restricted\Geocode\child1.dta", clear

merge 1:1 childid using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Restricted\Geocode\child2.dta"
drop _merge

merge 1:1 childid using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Restricted\Geocode\child3.dta"
drop _merge

merge 1:1 childid using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Restricted\Geocode\child4.dta"
drop _merge

merge 1:1 childid using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Restricted\Geocode\child5.dta"
drop _merge

save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Restricted\Geocode\child-all.dta", replace

log close

// School

infix s_id 1-4 ///
	  dispcde 5 ///
	  tract 6-16 ///
	  zcta 17-21 ///
	  rzip 22-26 ///
	  latitude 27-38 ///
	  longitude 39-50 ///
	  using "C:\Users\wodtke\Desktop\ecls_k98\restricted\ECLS-K Census Data and Geocodes\school.dat", clear
	  
label define dispcde_labels ///
	  1 "Automatically Matched" ///
	  2 "Address Edit or Phone" ///
	  3 "Not Matched"
label values dispcde dispcde_labels

save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Restricted\Geocode\school.dta", replace

// Tracts

#delimit ;

infix
TRACT        1-11
XHMD1        12-18
XHMD2        19-25
XHMD3        26-32
XPMD1        33-39
XPMD1W       40-46
XPMD1B       47-53
XPMD1I       54-60
XPMD1A       61-67
XPMD1O       68-74
XPMD1M       75-81
XPMD1H       82-88
XPMD1N       89-95
XPMD2        96-102
XPMD3        103-109
XPAV1        110-116
XPAV1W       117-123
XPAV1B       124-130
XPAV1I       131-137
XPAV1A       138-144
XPAV1O       145-151
XPAV1M       152-158
XPAV1H       159-165
XPAV1N       166-172
XAR1         173-179   
XAR2         180-190
XPTP1        191-201
XPRA1        202-212
XPRA2        213-223
XPRA3        224-234
XPRA4        235-245
XPRA5        246-256
XPRA6        257-267
XPHR1        268-278
XPHR2        279-289
XPHR3        290-300
XPHR4        301-311
XPHR5        312-322
XPHR6        323-333
XPHR7        334-344
XPHR8        345-355
XPHR9        356-366
XPHR10       367-377
XPHR11       378-388
XPHR12       389-399
XPHR13       400-410
XPSX1        411-421
XPSX2        422-432
XPOK1        433-443
XPOK2        444-454
XPOK3        455-465
XPOK4        466-476
XPOK5        477-487
XPOK6        488-498
XPOK7        499-509
XPOK8        510-520
XPOK9        521-531
XPOK10       532-542
XPOK11       543-553
XPOK12       554-564
XPOK13       565-575
XPOK14       576-586
XPOK15       587-597
XPOK16       598-608
XPOK17       609-619
XPOK18       620-630
XPOK19       631-641
XPOK20       642-652
XPOK21       653-663
XPOK22       664-674
XPOK23       675-685
XPOK24       686-696
XPOK25       697-707
XPOK26       708-718
XPOK27       719-729
XPOK28       730-740
XPMS1        741-751
XPMS2        752-762
XPMS3        763-773
XPMS4        774-784
XPMS5        785-795
XPMS6        796-806
XPLI1        807-817
XPLI2        818-828
XPLI3        829-839
XPLI4        840-850
XPLI5        851-861
XPLI6        862-872
XPFB1        873-883
XPAG1        884-894
XPAG2        895-905
XPPV1        906-916
XPPV2        917-927
XPDO1        928-938
XPDO2        939-949
XPDO3        950-960
XPDO1W       961-971
XPDO2W       972-982
XPDO3W       983-993
XPDO1B       994-1004
XPDO2B       1005-1015
XPDO3B       1016-1026
XPDO1I       1027-1037
XPDO2I       1038-1048
XPDO3I       1049-1059
XPDO1A       1060-1070
XPDO2A       1071-1081
XPDO3A       1082-1092
XPDO1O       1093-1103
XPDO2O       1104-1114
XPDO3O       1115-1125
XPDO1M       1126-1136
XPDO2M       1137-1147
XPDO3M       1148-1158
XPDO1H       1159-1169
XPDO2H       1170-1180
XPDO3H       1181-1191
XPDO1N       1192-1202
XPDO2N       1203-1213
XPDO3N       1214-1224
XPOC1        1225-1235
XPOC2        1236-1246
XPOC3        1247-1257
XPOC4        1258-1268
XPOC5        1269-1279
XPOC6        1280-1290
XPOC7        1291-1301
XPOC8        1302-1312
XPOC9        1313-1323
XPLF1        1324-1334
XPLF2        1335-1345
XPLF3        1346-1356
XPLF4        1357-1367
XPLF5        1368-1378
XPLF6        1379-1389
XPLF7        1390-1400
XPLF8        1401-1411
XPLF9        1412-1422
XPLF10       1423-1433
XPLF11       1434-1444
XPLF12       1445-1455
XPLF13       1456-1466
XPLF14       1467-1477
XPLF15       1478-1488
XPLF16       1489-1499
XPLF17       1500-1510
XPLF18       1511-1521
XPCL1        1522-1532
XPCL2        1533-1543
XPCL3        1544-1554
XPCL4        1555-1565
XPCL5        1566-1576
XPCL6        1577-1587
XPCL7        1588-1598
XPED1        1599-1609
XPED2        1610-1620
XPED3        1621-1631
XPED4        1632-1642
XPED5        1643-1653
XPED6        1654-1664
XPED1W       1665-1675
XPED2W       1676-1686
XPED3W       1687-1697
XPED4W       1698-1708
XPED5W       1709-1719
XPED6W       1720-1730
XPED1B       1731-1741
XPED2B       1742-1752
XPED3B       1753-1763
XPED4B       1764-1774
XPED5B       1775-1785
XPED6B       1786-1796
XPED1I       1797-1807
XPED2I       1808-1818
XPED3I       1819-1829
XPED4I       1830-1840
XPED5I       1841-1851
XPED6I       1852-1862
XPED1A       1863-1873
XPED2A       1874-1884
XPED3A       1885-1895
XPED4A       1896-1906
XPED5A       1907-1917
XPED6A       1918-1928
XPED1O       1929-1939
XPED2O       1940-1950
XPED3O       1951-1961
XPED4O       1962-1972
XPED5O       1973-1983
XPED6O       1984-1994
XPED1M       1995-2005
XPED2M       2006-2016
XPED3M       2017-2027
XPED4M       2028-2038
XPED5M       2039-2049
XPED6M       2050-2060
XPED1H       2061-2071
XPED2H       2072-2082
XPED3H       2083-2093
XPED4H       2094-2104
XPED5H       2105-2115
XPED6H       2116-2126
XPED1N       2127-2137
XPED2N       2138-2148
XPED3N       2149-2159
XPED4N       2160-2170
XPED5N       2171-2181
XPED6N       2182-2192
XPHH         2193-2203
XPHT1        2204-2214
XPHT2        2215-2225
XPHT3        2226-2236
XPHT4        2237-2247
XPHT5        2248-2258
XPHT6        2259-2269
XPHT7        2270-2280
XPHT8        2281-2291
XPHT9        2292-2302
XPHHW        2303-2313
XPHT1W       2314-2324
XPHT2W       2325-2335
XPHT3W       2336-2346
XPHT4W       2347-2357
XPHT5W       2358-2368
XPHT6W       2369-2379
XPHT7W       2380-2390
XPHT8W       2391-2401
XPHT9W       2402-2412
XPHHB        2413-2423
XPHT1B       2424-2434
XPHT2B       2435-2445
XPHT3B       2446-2456
XPHT4B       2457-2467
XPHT5B       2468-2478
XPHT6B       2479-2489
XPHT7B       2490-2500
XPHT8B       2501-2511
XPHT9B       2512-2522
XPHHI        2523-2533
XPHT1I       2534-2544
XPHT2I       2545-2555
XPHT3I       2556-2566
XPHT4I       2567-2577
XPHT5I       2578-2588
XPHT6I       2589-2599
XPHT7I       2600-2610
XPHT8I       2611-2621
XPHT9I       2622-2632
XPHHA        2633-2643
XPHT1A       2644-2654
XPHT2A       2655-2665
XPHT3A       2666-2676
XPHT4A       2677-2687
XPHT5A       2688-2698
XPHT6A       2699-2709
XPHT7A       2710-2720
XPHT8A       2721-2731
XPHT9A       2732-2742
XPHHO        2743-2753
XPHT1O       2754-2764
XPHT2O       2765-2775
XPHT3O       2776-2786
XPHT4O       2787-2797
XPHT5O       2798-2808
XPHT6O       2809-2819
XPHT7O       2820-2830
XPHT8O       2831-2841
XPHT9O       2842-2852
XPHHM        2853-2863
XPHT1M       2864-2874
XPHT2M       2875-2885
XPHT3M       2886-2896
XPHT4M       2897-2907
XPHT5M       2908-2918
XPHT6M       2919-2929
XPHT7M       2930-2940
XPHT8M       2941-2951
XPHT9M       2952-2962
XPHHH        2963-2973
XPHT1H       2974-2984
XPHT2H       2985-2995
XPHT3H       2996-3006
XPHT4H       3007-3017
XPHT5H       3018-3028
XPHT6H       3029-3039
XPHT7H       3040-3050
XPHT8H       3051-3061
XPHT9H       3062-3072
XPHHN        3073-3083
XPHT1N       3084-3094
XPHT2N       3095-3105
XPHT3N       3106-3116
XPHT4N       3117-3127
XPHT5N       3128-3138
XPHT6N       3139-3149
XPHT7N       3150-3160
XPHT8N       3161-3171
XPHT9N       3172-3182
XPFP1        3183-3193
XPFP2        3194-3204
XPFP3        3205-3215
XPFP1W       3216-3226
XPFP2W       3227-3237
XPFP3W       3238-3248
XPFP1B       3249-3259
XPFP2B       3260-3270
XPFP3B       3271-3281
XPFP1I       3282-3292
XPFP2I       3293-3303
XPFP3I       3304-3314
XPFP1A       3315-3325
XPFP2A       3326-3336
XPFP3A       3337-3347
XPFP1O       3348-3358
XPFP2O       3359-3369
XPFP3O       3370-3380
XPFP1M       3381-3391
XPFP2M       3392-3402
XPFP3M       3403-3413
XPFP1H       3414-3424
XPFP2H       3425-3435
XPFP3H       3436-3446
XPFP1N       3447-3457
XPFP2N       3458-3468
XPFP3N       3469-3479
XHTP1        3480-3490
XHHU         3491-3501
XHTN1        3502-3512
XHTN2        3513-3523
XHTN3        3524-3534
XHTB1        3535-3545
XHTB2        3546-3556
XHTB3        3557-3567
XHTB4        3568-3578
XHTB5        3579-3589
XHTB6        3590-3600
XPPA1        3601-3611
X_PRA1       3612-3618 
X_PRA2       3619-3625 
X_PRA3       3626-3632 
X_PRA4       3633-3639 
X_PRA5       3640-3646 
X_PRA6       3647-3653 
X_PHR1       3654-3660 
X_PHR2       3661-3667 
X_PHR3       3668-3674 
X_PHR4       3675-3681 
X_PHR5       3682-3688 
X_PHR6       3689-3695 
X_PHR7       3696-3702 
X_PHR8       3703-3709 
X_PHR9       3710-3716 
X_PHR10      3717-3723 
X_PHR11      3724-3730 
X_PHR12      3731-3737 
X_PHR13      3738-3744 
X_POK2       3745-3751 
X_POK3       3752-3758 
X_POK4       3759-3765 
X_POK6       3766-3772 
X_POK7       3773-3779 
X_POK8       3780-3786 
X_POK10      3787-3793 
X_POK11      3794-3800 
X_POK12      3801-3807 
X_POK14      3808-3814 
X_POK15      3815-3821 
X_POK16      3822-3828 
X_POK18      3829-3835 
X_POK19      3836-3842 
X_POK20      3843-3849 
X_POK22      3850-3856 
X_POK23      3857-3863 
X_POK24      3864-3870 
X_POK26      3871-3877 
X_POK27      3878-3884 
X_POK28      3885-3891 
X_PSX1       3892-3898 
X_PSX2       3899-3905 
X_PMS2       3906-3912 
X_PMS3       3913-3919 
X_PMS4       3920-3926 
X_PMS5       3927-3933 
X_PMS6       3934-3940 
X_PLI1       3941-3947 
X_PLI2       3948-3954 
X_PLI3       3955-3961 
X_PLI4       3962-3968 
X_PLI5       3969-3975 
X_PLI6       3976-3982 
X_PFB1       3983-3989 
X_PPV2       3990-3996 
X_PAG1       3997-4003 
X_PAG2       4004-4010 
X_PDO1       4011-4017 
X_PDO2       4018-4024 
X_PDO3       4025-4031 
X_PDO1W      4032-4038 
X_PDO2W      4039-4045 
X_PDO3W      4046-4052 
X_PDO1B      4053-4059 
X_PDO2B      4060-4066 
X_PDO3B      4067-4073 
X_PDO1I      4074-4080 
X_PDO2I      4081-4087 
X_PDO3I      4088-4094 
X_PDO1A      4095-4101 
X_PDO2A      4102-4108 
X_PDO3A      4109-4115 
X_PDO1O      4116-4122 
X_PDO2O      4123-4129 
X_PDO3O      4130-4136 
X_PDO1M      4137-4143 
X_PDO2M      4144-4150 
X_PDO3M      4151-4157 
X_PDO1H      4158-4164 
X_PDO2H      4165-4171 
X_PDO3H      4172-4178 
X_PDO1N      4179-4185 
X_PDO2N      4186-4192 
X_PDO3N      4193-4199 
X_POC2       4200-4206 
X_POC3       4207-4213 
X_POC4       4214-4220 
X_POC5       4221-4227 
X_POC6       4228-4234 
X_POC7       4235-4241 
X_POC8       4242-4248 
X_POC9       4249-4255 
X_PLF1       4256-4262 
X_PLF2       4263-4269 
X_PLF3       4270-4276 
X_PLF4       4277-4283 
X_PLF5       4284-4290 
X_PLF6       4291-4297 
X_PLF7       4298-4304 
X_PLF8       4305-4311 
X_PLF9       4312-4318 
X_PLF10      4319-4325 
X_PLF11      4326-4332 
X_PLF12      4333-4339 
X_PLF13      4340-4346 
X_PLF14      4347-4353 
X_PLF15      4354-4360 
X_PLF16      4361-4367 
X_PLF17      4368-4374 
X_PLF18      4375-4381 
X_PCL1       4382-4388 
X_PCL2       4389-4395 
X_PCL3       4396-4402 
X_PCL4       4403-4409 
X_PCL5       4410-4416 
X_PCL6       4417-4423 
X_PCL7       4424-4430 
X_PED1       4431-4437 
X_PED2       4438-4444 
X_PED3       4445-4451 
X_PED4       4452-4458 
X_PED5       4459-4465 
X_PED6       4466-4472 
X_PED1W      4473-4479 
X_PED2W      4480-4486 
X_PED3W      4487-4493 
X_PED4W      4494-4500 
X_PED5W      4501-4507 
X_PED6W      4508-4514 
X_PED1B      4515-4521 
X_PED2B      4522-4528 
X_PED3B      4529-4535 
X_PED4B      4536-4542 
X_PED5B      4543-4549 
X_PED6B      4550-4556 
X_PED1I      4557-4563 
X_PED2I      4564-4570 
X_PED3I      4571-4577 
X_PED4I      4578-4584 
X_PED5I      4585-4591 
X_PED6I      4592-4598 
X_PED1A      4599-4605 
X_PED2A      4606-4612 
X_PED3A      4613-4619 
X_PED4A      4620-4626 
X_PED5A      4627-4633 
X_PED6A      4634-4640 
X_PED1O      4641-4647 
X_PED2O      4648-4654 
X_PED3O      4655-4661 
X_PED4O      4662-4668 
X_PED5O      4669-4675 
X_PED6O      4676-4682 
X_PED1M      4683-4689 
X_PED2M      4690-4696 
X_PED3M      4697-4703 
X_PED4M      4704-4710 
X_PED5M      4711-4717 
X_PED6M      4718-4724 
X_PED1H      4725-4731 
X_PED2H      4732-4738 
X_PED3H      4739-4745 
X_PED4H      4746-4752 
X_PED5H      4753-4759 
X_PED6H      4760-4766 
X_PED1N      4767-4773 
X_PED2N      4774-4780 
X_PED3N      4781-4787 
X_PED4N      4788-4794 
X_PED5N      4795-4801 
X_PED6N      4802-4808 
X_PHT1       4809-4815 
X_PHT2       4816-4822 
X_PHT3       4823-4829 
X_PHT4       4830-4836 
X_PHT5       4837-4843 
X_PHT6       4844-4850 
X_PHT7       4851-4857 
X_PHT8       4858-4864 
X_PHT9       4865-4871 
X_PHHW       4872-4878 
X_PHT1W      4879-4885 
X_PHT2W      4886-4892 
X_PHT3W      4893-4899 
X_PHT4W      4900-4906 
X_PHT5W      4907-4913 
X_PHT6W      4914-4920 
X_PHT7W      4921-4927 
X_PHT8W      4928-4934 
X_PHT9W      4935-4941 
X_PHHB       4942-4948 
X_PHT1B      4949-4955 
X_PHT2B      4956-4962 
X_PHT3B      4963-4969 
X_PHT4B      4970-4976 
X_PHT5B      4977-4983 
X_PHT6B      4984-4990 
X_PHT7B      4991-4997 
X_PHT8B      4998-5004 
X_PHT9B      5005-5011 
X_PHHI       5012-5018 
X_PHT1I      5019-5025 
X_PHT2I      5026-5032 
X_PHT3I      5033-5039 
X_PHT4I      5040-5046 
X_PHT5I      5047-5053 
X_PHT6I      5054-5060 
X_PHT7I      5061-5067 
X_PHT8I      5068-5074 
X_PHT9I      5075-5081 
X_PHHA       5082-5088 
X_PHT1A      5089-5095 
X_PHT2A      5096-5102 
X_PHT3A      5103-5109 
X_PHT4A      5110-5116 
X_PHT5A      5117-5123 
X_PHT6A      5124-5130 
X_PHT7A      5131-5137 
X_PHT8A      5138-5144 
X_PHT9A      5145-5151 
X_PHHO       5152-5158 
X_PHT1O      5159-5165 
X_PHT2O      5166-5172 
X_PHT3O      5173-5179 
X_PHT4O      5180-5186 
X_PHT5O      5187-5193 
X_PHT6O      5194-5200 
X_PHT7O      5201-5207 
X_PHT8O      5208-5214 
X_PHT9O      5215-5221 
X_PHHM       5222-5228 
X_PHT1M      5229-5235 
X_PHT2M      5236-5242 
X_PHT3M      5243-5249 
X_PHT4M      5250-5256 
X_PHT5M      5257-5263 
X_PHT6M      5264-5270 
X_PHT7M      5271-5277 
X_PHT8M      5278-5284 
X_PHT9M      5285-5291 
X_PHHH       5292-5298 
X_PHT1H      5299-5305 
X_PHT2H      5306-5312 
X_PHT3H      5313-5319 
X_PHT4H      5320-5326 
X_PHT5H      5327-5333 
X_PHT6H      5334-5340 
X_PHT7H      5341-5347 
X_PHT8H      5348-5354 
X_PHT9H      5355-5361 
X_PHHN       5362-5368 
X_PHT1N      5369-5375 
X_PHT2N      5376-5382 
X_PHT3N      5383-5389 
X_PHT4N      5390-5396 
X_PHT5N      5397-5403 
X_PHT6N      5404-5410 
X_PHT7N      5411-5417 
X_PHT8N      5418-5424 
X_PHT9N      5425-5431 
X_PFP1       5432-5438 
X_PFP2       5439-5445 
X_PFP3       5446-5452 
X_PFP1W      5453-5459 
X_PFP2W      5460-5466 
X_PFP3W      5467-5473 
X_PFP1B      5474-5480 
X_PFP2B      5481-5487 
X_PFP3B      5488-5494 
X_PFP1I      5495-5501 
X_PFP2I      5502-5508 
X_PFP3I      5509-5515 
X_PFP1A      5516-5522 
X_PFP2A      5523-5529 
X_PFP3A      5530-5536 
X_PFP1O      5537-5543 
X_PFP2O      5544-5550 
X_PFP3O      5551-5557 
X_PFP1M      5558-5564 
X_PFP2M      5565-5571 
X_PFP3M      5572-5578 
X_PFP1H      5579-5585 
X_PFP2H      5586-5592 
X_PFP3H      5593-5599 
X_PFP1N      5600-5606 
X_PFP2N      5607-5613 
X_PFP3N      5614-5620 
X_PPA1       5621-5627 
X_HTP1       5628-5634 
X_HTN1       5635-5641 
X_HTN2       5642-5648 
X_HTN3       5649-5655 
X_HTB1       5656-5662 
X_HTB2       5663-5669 
X_HTB3       5670-5676 
X_HTB4       5677-5683 
X_HTB5       5684-5690 
X_HTB6       5691-5697 
using "C:\Users\wodtke\Desktop\ecls_k98\restricted\ECLS-K Census Data and Geocodes\tracts.dat", clear;

#delimit cr

label variable TRACT    "Tract Code Census 2000"
label variable XHMD1    "MEDIAN RENT (H0630001 )"
label variable XHMD2    "MED VALUE ALL OWN OCC (H0850001)"
label variable XHMD3    "MEDIAN SEL MONTHLY OWN COSTS (CONSTRUCTED"
label variable XPMD1    "MEDIAN HH INCOME (P0530001)"
label variable XPMD1W   "MEDIAN HH INCOME: WHITE (P152A001)"
label variable XPMD1B   "MEDIAN HH INCOME: BLACK (P152B001)"
label variable XPMD1I   "MEDIAN HH INCOME: AMIND (P152C001)"
label variable XPMD1A   "MEDIAN HH INCOME: ASIAN (CONSTRUCTED)"
label variable XPMD1O   "MEDIAN HH INCOME: OTHER (P152F001)"
label variable XPMD1M   "MEDIAN HH INCOME: MULTI (P152G001)"
label variable XPMD1H   "MEDIAN HH INCOME: HISP (P152H001)"
label variable XPMD1N   "MEDIAN HH INCOME: NH WHITE (P152I001)"
label variable XPMD2    "MEDIAN FAM INC (P0770001)"
label variable XPMD3    "MEDIAN NON FAMILY INCOME (P0800001)"
label variable XPAV1    "AVG HH INCOME (CONSTRUCTED)"
label variable XPAV1W   "AVG HH INCOME: WHITE (CONSTRUCTED)"
label variable XPAV1B   "AVG HH INCOME: BLACK (CONSTRUCTED)"
label variable XPAV1I   "AVG HH INCOME: AMIND (CONSTRUCTED)"
label variable XPAV1A   "AVG HH INCOME: ASIAN (CONSTRUCTED)"
label variable XPAV1O   "AVG HH INCOME: OTHER (CONSTRUCTED)"
label variable XPAV1M   "AVG HH INCOME: MULTI (CONSTRUCTED)"
label variable XPAV1H   "AVG HH INCOME: HISP (CONSTRUCTED)"
label variable XPAV1N   "AVG HH INCOME: NH WHITE (CONSTRUCTED)"
label variable XAR1     "LAND AREA  (CONSTRUCTED)"
label variable XAR2     "POPULATION DENSITY (CONSTRUCTED)"
label variable XPTP1    "TOTAL POP (P0060001)"
label variable XPRA1    "WHITE  (P0060002)"
label variable XPRA2    "BLACK  (P0060003)"
label variable XPRA3    "AMIND  (P0060004)"
label variable XPRA4    "ASIAN  (P0060005+P0060006)"
label variable XPRA5    "OTHER  (P0060007)"
label variable XPRA6    "MULTI RACE (P0060008)"
label variable XPHR1    "HISP (P0070010)"
label variable XPHR2    "NH WHITE (P0070003)"
label variable XPHR3    "NH BLACK (P0070004)"
label variable XPHR4    "NH AMIND (P0070005)"
label variable XPHR5    "NH ASIAN (P0070006+P0070007)"
label variable XPHR6    "NH OTHER (P0070008)"
label variable XPHR7    "NH MULTI (P0070009)"
label variable XPHR8    "HISP WHITE (P0070011)"
label variable XPHR9    "HISP BLACK (P0070012)"
label variable XPHR10   "HISP AMIND (P0070013)"
label variable XPHR11   "HISP ASIAN (P0070014+P0070015)"
label variable XPHR12   "HISP OTHER (P0070016)"
label variable XPHR13   "HISP MULTI (P0070017)"
label variable XPSX1    "MALE (P0080002)"
label variable XPSX2    "FEMALE (P0080041)"
label variable XPOK1    "OWN KIDS 0-17 (PERSONS)  (P0160001)"
label variable XPOK2    "OWN KIDS 0-17: IN MAR COUP FAM (P0160002)"
label variable XPOK3    "OWN KIDS 0-17: IN MALE HEAD FAM (P0160011)"
label variable XPOK4    "OWN KIDS 0-17: IN FEM HEAD FAM  (P0160019)"
label variable XPOK5    "OWN KIDS AGE 0-2 (CONSTRUCTED)"
label variable XPOK6    "OWN KIDS AGE 0-2: IN MAR COUP HH (P0160003"
label variable XPOK7    "OWN KIDS AGE 0-2: IN MALE HEAD HH (P016001"
label variable XPOK8    "OWN KIDS AGE 0-2: IN FEM HEAD HH (P0160020"
label variable XPOK9    "OWN KIDS AGE 3-5 (CONSTRUCTED)"
label variable XPOK10   "OWN KIDS AGE 3-5: IN MAR COUP HH (CONSTRUC"
label variable XPOK11   "OWN KIDS AGE 3-5: IN MALE HEAD HH (CONSTRU"
label variable XPOK12   "OWN KIDS AGE 3-5: IN FEM HEAD HH (CONSTRUC"
label variable XPOK13   "OWN KIDS 6-11 (CONSTRUCTED)"
label variable XPOK14   "OWN KIDS 6-11: IN MAR COUP FAM (P0160006)"
label variable XPOK15   "OWN KIDS 6-11: IN MALE HEAD FAM (P0160015)"
label variable XPOK16   "OWN KIDS 6-11: IN FEM HEAD FAM (P0160023)"
label variable XPOK17   "OWN KIDS 12-13 (CONSTRUCTED)"
label variable XPOK18   "OWN KIDS 12-13: IN MAR COUP FAM (P0160007)"
label variable XPOK19   "OWN KIDS 12-13: IN MALE HEAD FAM (P0160016"
label variable XPOK20   "OWN KIDS 12-13: IN FEM HEAD FAM (P0160024)"
label variable XPOK21   "OWN KIDS AGE 14 (CONSTRUCTED)"
label variable XPOK22   "OWN KIDS AGE 14: IN MAR COUP FAM (P0160008"
label variable XPOK23   "OWN KIDS AGE 14: IN MALE HEAD FAM (P016001"
label variable XPOK24   "OWN KIDS AGE 14: IN FEM HEAD FAM (P0160025"
label variable XPOK25   "OWN KIDS 15-17 (CONSTRUCTED)"
label variable XPOK26   "OWN KIDS 15-17: IN MAR COUP FAM (P0160009)"
label variable XPOK27   "OWN KIDS 15-17: IN MALE HEAD FAM (P0160018"
label variable XPOK28   "OWN KIDS 15-17: IN FEM HEAD FAM (P0160026)"
label variable XPMS1    "AGE 15+ (P0180001)"
label variable XPMS2    "AGE 15+: SINGLE (CONSTRUCTED)"
label variable XPMS3    "AGE 15+: MARRIED (CONSTRUCTED)"
label variable XPMS4    "AGE 15+: SEPARATED (CONSTRUCTED)"
label variable XPMS5    "AGE 15+: WIDOWED (CONSTRUCTED)"
label variable XPMS6    "AGE 15+: DIVORCED (CONSTRUCTED)"
label variable XPLI1    "POP 5+ IN HH"
label variable XPLI2    "POP 5+: LING ISOLATED (CONSTRUCTED)"
label variable XPLI3    "LING ISOLATED: AGE 5-17 (CONSTRUCTED)"
label variable XPLI4    "LING ISOLATED: AGE 18-44 (CONSTRUCTED)"
label variable XPLI5    "LING ISOLATED: AGE 45-64 (CONSTRUCTED)"
label variable XPLI6    "LING ISOLATED: AGE 65 + (CONSTRUCTED)"
label variable XPFB1    "FOREIGN BORN (P0210013)"
label variable XPAG1    "AGE 0-17 (CONSTRUCTED)"
label variable XPAG2    "AGE 65 + (CONSTRUCTED)"
label variable XPPV1    "PERSONS POV STATUS DETERM (P0870001)"
label variable XPPV2    "PERSONS BELOW POV (P0870002)"
label variable XPDO1    "AGE 16-19 (P0380001)"
label variable XPDO2    "CIV 16-19 (P0380009)"
label variable XPDO3    "CIV 16-19: DROPOUT (P0380019)"
label variable XPDO1W   "AGE 16-19: WHITE (P149A001)"
label variable XPDO2W   "CIV 16-19: WHITE  (P149A009)"
label variable XPDO3W   "CIV 16-19: WHITE DROPOUT (P149A019)"
label variable XPDO1B   "AGE 16-19: BLACK (P149B001)"
label variable XPDO2B   "CIV 16-19: BLACK (P149B009)"
label variable XPDO3B   "CIV 16-19: BLACK DROPOUT (P149B019)"
label variable XPDO1I   "AGE 16-19: AMIND (P149C001)"
label variable XPDO2I   "CIV 16-19: AMIND (P149C009)"
label variable XPDO3I   "CIV 16-19: AMIND DROPOUT (P149C019)"
label variable XPDO1A   "AGE 16-19: ASIAN (CONSTRUCTED)"
label variable XPDO2A   "CIV 16-19: ASIAN (CONSTRUCTED)"
label variable XPDO3A   "CIV 16-19: ASIAN DROPOUT (CONSTRUCTED)"
label variable XPDO1O   "AGE 16-19: OTHER (P149F001)"
label variable XPDO2O   "CIV 16-19: OTHER (P149F009)"
label variable XPDO3O   "CIV 16-19: OTHER DROPOUT (P149F019)"
label variable XPDO1M   "AGE 16-19: MULTI (P149G001)"
label variable XPDO2M   "CIV 16-19: MULTI (P149G009)"
label variable XPDO3M   "CIV 16-19: MULTI DROPOUT (P149G019)"
label variable XPDO1H   "AGE 16-19: HISP (P149H001)"
label variable XPDO2H   "CIV 16-19: HISP (P149H009)"
label variable XPDO3H   "CIV 16-19: HISP DROPOUT (P149H019)"
label variable XPDO1N   "AGE 16-19: NH WHITE (P149I001)"
label variable XPDO2N   "CIV 16-19: NH WHITE (P149I009)"
label variable XPDO3N   "CIV 16-19: NH WHITE DROPOUT (P149I019)"
label variable XPOC1    "AGE 16+ EMP (P0500001)"
label variable XPOC2    "OCC 16+: MAN/BUS/FIN (CONSTRUCTED)"
label variable XPOC3    "OCC 16+: PROF AND REL (CONSTRUCTED)"
label variable XPOC4    "OCC 16+: SERVICE (CONSTRUCTED)"
label variable XPOC5    "OCC 16+: SALES (CONSTRUCTED)"
label variable XPOC6    "OCC 16+: OFFICE/ADM SUP (CONSTRUCTED)"
label variable XPOC7    "OCC 16+: FOR/FARM/FISH (CONSTRUCTED)"
label variable XPOC8    "OCC 16+: CONSTR/EXTR/MAINT (CONSTRUCTED)"
label variable XPOC9    "OCC 16+: PROD/TRANS/MAT MOV (CONSTRUCTED)"
label variable XPLF1    "AGE 16+ (P0430001)"
label variable XPLF2    "AGE 16+: IN CIV LF (CONSTRUCTED)"
label variable XPLF3    "AGE 16+: IN CIV LF: EMP (CONSTRUCTED)"
label variable XPLF4    "AGE 16+: IN CIV LF: UNEMP (CONSTRUCTED)"
label variable XPLF5    "AGE 16+: NILF (CONSTRUCTED)"
label variable XPLF6    "AGE 16+: ARMY (CONSTRUCTED)"
label variable XPLF7    "MALE 16+ (P0430002)"
label variable XPLF8    "MALE 16+: IN CIV LF (P0430005)"
label variable XPLF9    "MALE 16+: IN CIV LF: EMP (P0430006)"
label variable XPLF10   "MALE 16+: IN CIV LF: UNEMP (P0430007)"
label variable XPLF11   "MALE 16+: NILF (P0430008)"
label variable XPLF12   "MALE 16+: ARMY (P0430004)"
label variable XPLF13   "FEM 16+ (P0430009)"
label variable XPLF14   "FEM 16+: IN CIV LF (P0430012)"
label variable XPLF15   "FEM 16+: IN CIV LF: EMP (P0430013)"
label variable XPLF16   "FEM 16+: IN CIV LF: UNEMP (P0430014)"
label variable XPLF17   "FEM 16+: NILF (P0430015)"
label variable XPLF18   "FEM 16+: ARMY (P0430011)"
label variable XPCL1    "EMP 16+: PRIV FOR PROFIT (CONSTRUCTED)"
label variable XPCL2    "EMP 16+: PRIV NON PROFIT (CONSTRUCTED)"
label variable XPCL3    "EMP 16+: LOCAL GOVT"
label variable XPCL4    "EMP 16+: STATE GOVT"
label variable XPCL5    "EMP 16+: FED GOVT"
label variable XPCL6    "EMP 16+: SELF EMP"
label variable XPCL7    "EMP 16+: UNPAID FAM WRKR"
label variable XPED1    "AGE 25+ (P0370001)"
label variable XPED2    "AGE 25+: LESS THAN HS (CONSTRUCTED)"
label variable XPED3    "AGE 25+: HS GRAD (CONSTRUCTED)"
label variable XPED4    "AGE 25+: SOME COLLEGE (CONSTRUCTED)"
label variable XPED5    "AGE 25+: BA DEGREE (CONSTRUCTED)"
label variable XPED6    "AGE 25+: MA+ DEGREE (CONSTRUCTED)"
label variable XPED1W   "AGE 25+ WHITE (P148A001)"
label variable XPED2W   "AGE 25+ WHITE: LESS THAN HS (CONSTRUCTED)"
label variable XPED3W   "AGE 25+ WHITE: HS GRAD (CONSTRUCTED)"
label variable XPED4W   "AGE 25+ WHITE: SOME COLLEGE (CONSTRUCTED)"
label variable XPED5W   "AGE 25+ WHITE: BA DEGREE (CONSTRUCTED)"
label variable XPED6W   "AGE 25+ WHITE: MA+ DEGREE (CONSTRUCTED)"
label variable XPED1B   "AGE 25+ BLACK (P148B001)"
label variable XPED2B   "AGE 25+ BLACK: LESS THAN HS (CONSTRUCTED)"
label variable XPED3B   "AGE 25+ BLACK: HS GRAD (CONSTRUCTED)"
label variable XPED4B   "AGE 25+ BLACK: SOME COLLEGE (CONSTRUCTED)"
label variable XPED5B   "AGE 25+ BLACK: BA DEGREE (CONSTRUCTED)"
label variable XPED6B   "AGE 25+ BLACK: MA+ DEGREE (CONSTRUCTED)"
label variable XPED1I   "AGE 25+ AMIND (P148C001)"
label variable XPED2I   "AGE 25+ AMIND: LESS THAN HS (CONSTRUCTED)"
label variable XPED3I   "AGE 25+ AMIND: HS GRAD (CONSTRUCTED)"
label variable XPED4I   "AGE 25+ AMIND: SOME COLLEGE (CONSTRUCTED)"
label variable XPED5I   "AGE 25+ AMIND: BA DEGREE (CONSTRUCTED)"
label variable XPED6I   "AGE 25+ AMIND: MA+ DEGREE (CONSTRUCTED)"
label variable XPED1A   "AGE 25+ ASIAN (CONSTRUCTED) (CONSTRUCTED)"
label variable XPED2A   "AGE 25+ ASIAN: LESS THAN HS (CONSTRUCTED)"
label variable XPED3A   "AGE 25+ ASIAN: HS GRAD (CONSTRUCTED)"
label variable XPED4A   "AGE 25+ ASIAN: SOME COLLEGE (CONSTRUCTED)"
label variable XPED5A   "AGE 25+ ASIAN: BA DEGREE (CONSTRUCTED)"
label variable XPED6A   "AGE 25+ ASIAN: MA+ DEGREE (CONSTRUCTED)"
label variable XPED1O   "AGE 25+ OTHER (P148F001)"
label variable XPED2O   "AGE 25+ OTHER: LESS THAN HS (CONSTRUCTED)"
label variable XPED3O   "AGE 25+ OTHER: HS GRAD (CONSTRUCTED)"
label variable XPED4O   "AGE 25+ OTHER: SOME COLLEGE (CONSTRUCTED)"
label variable XPED5O   "AGE 25+ OTHER: BA DEGREE (CONSTRUCTED)"
label variable XPED6O   "AGE 25+ OTHER: MA+ DEGREE (CONSTRUCTED)"
label variable XPED1M   "AGE 25+ MULTI (P148G001)"
label variable XPED2M   "AGE 25+ MULTI: LESS THAN HS (CONSTRUCTED)"
label variable XPED3M   "AGE 25+ MULTI: HS GRAD (CONSTRUCTED)"
label variable XPED4M   "AGE 25+ MULTI: SOME COLLEGE (CONSTRUCTED)"
label variable XPED5M   "AGE 25+ MULTI: BA DEGREE (CONSTRUCTED)"
label variable XPED6M   "AGE 25+ MULTI: MA+ DEGREE (CONSTRUCTED)"
label variable XPED1H   "AGE 25+ HISP (P148H001)"
label variable XPED2H   "AGE 25+ HISP: LESS THAN HS (CONSTRUCTED)"
label variable XPED3H   "AGE 25+ HISP: HS GRAD (CONSTRUCTED)"
label variable XPED4H   "AGE 25+ HISP: SOME COLLEGE (CONSTRUCTED)"
label variable XPED5H   "AGE 25+ HISP: BA DEGREE (CONSTRUCTED)"
label variable XPED6H   "AGE 25+ HISP: MA+ DEGREE (CONSTRUCTED)"
label variable XPED1N   "AGE 25+ NH WHITE (P148I001)"
label variable XPED2N   "AGE 25+ NH WHITE: LESS THAN HS (CONSTRUCTE"
label variable XPED3N   "AGE 25+ NH WHITE: HS GRAD (CONSTRUCTED)"
label variable XPED4N   "AGE 25+ NH WHITE: SOME COLLEGE (CONSTRUCTE"
label variable XPED5N   "AGE 25+ NH WHITE: BA DEGREE (CONSTRUCTED)"
label variable XPED6N   "AGE 25+ NH WHITE: MA+ DEGREE (CONSTRUCTED)"
label variable XPHH     "HOUSHOLDS (P0100001)"
label variable XPHT1    "FAMILY HH (P0100006)"
label variable XPHT2    "FAM HH: MAR COUP OWN KIDS (P0100008)"
label variable XPHT3    "FAM HH: MAR COUP NO KIDS (P0100009)"
label variable XPHT4    "FAM HH: MALE HEAD OWN KIDS (P0100012)"
label variable XPHT5    "FAM HH: MALE HEAD NO KIDS (P0100013)"
label variable XPHT6    "FAM HH: FEM HEAD OWN KIDS (P0100015)"
label variable XPHT7    "FAM HH: FEM HEAD NO KIDS (P0100016)"
label variable XPHT8    "NON FAM HH: ALONE (P0100002)"
label variable XPHT9    "NON FAM HH: WITH OTHERS (P0100017)"
label variable XPHHW    "WHITE HOUSHOLDS (P146A001)"
label variable XPHT1W   "WHITE FAMILY HH (CONSTRUCTED)"
label variable XPHT2W   "WHITE FAM HH: MAR COUP OWN KIDS (CONSTRUCT"
label variable XPHT3W   "WHITE FAM HH: MAR COUP NO KIDS (CONSTRUCTE"
label variable XPHT4W   "WHITE FAM HH: MALE HEAD OWN KIDS (CONSTRUC"
label variable XPHT5W   "WHITE FAM HH: MALE HEAD NO KIDS (CONSTRUCT"
label variable XPHT6W   "WHITE FAM HH: FEM HEAD OWN KIDS (CONSTRUCT"
label variable XPHT7W   "WHITE FAM HH: FEM HEAD NO KIDS (CONSTRUCTE"
label variable XPHT8W   "WHITE NON FAM HH: ALONE (CONSTRUCTED)"
label variable XPHT9W   "WHITE NON FAM HH: WITH OTHERS (CONSTRUCTED"
label variable XPHHB    "BLACK HOUSHOLDS (P146B001)"
label variable XPHT1B   "BLACK FAMILY HH (CONSTRUCTED)"
label variable XPHT2B   "BLACK FAM HH: MAR COUP OWN KIDS (CONSTRUCT"
label variable XPHT3B   "BLACK FAM HH: MAR COUP NO KIDS (CONSTRUCTE"
label variable XPHT4B   "BLACK FAM HH: MALE HEAD OWN KIDS (CONSTRUC"
label variable XPHT5B   "BLACK FAM HH: MALE HEAD NO KIDS (CONSTRUCT"
label variable XPHT6B   "BLACK FAM HH: FEM HEAD OWN KIDS (CONSTRUCT"
label variable XPHT7B   "BLACK FAM HH: FEM HEAD NO KIDS (CONSTRUCTE"
label variable XPHT8B   "BLACK NON FAM HH: ALONE (CONSTRUCTED)"
label variable XPHT9B   "BLACK NON FAM HH: WITH OTHERS (CONSTRUCTED"
label variable XPHHI    "AMIND HOUSHOLDS (P146C001)"
label variable XPHT1I   "AMIND FAMILY HH (CONSTRUCTED)"
label variable XPHT2I   "AMIND FAM HH: MAR COUP OWN KIDS (CONSTRUCT"
label variable XPHT3I   "AMIND FAM HH: MAR COUP NO KIDS (CONSTRUCTE"
label variable XPHT4I   "AMIND FAM HH: MALE HEAD OWN KIDS (CONSTRUC"
label variable XPHT5I   "AMIND FAM HH: MALE HEAD NO KIDS (CONSTRUCT"
label variable XPHT6I   "AMIND FAM HH: FEM HEAD OWN KIDS (CONSTRUCT"
label variable XPHT7I   "AMIND FAM HH: FEM HEAD NO KIDS (CONSTRUCTE"
label variable XPHT8I   "AMIND NON FAM HH: ALONE (CONSTRUCTED)"
label variable XPHT9I   "AMIND NON FAM HH: WITH OTHERS (CONSTRUCTED"
label variable XPHHA    "ASIAN HOUSHOLDS (CONSTRUCTED)"
label variable XPHT1A   "ASIAN FAMILY HH (CONSTRUCTED)"
label variable XPHT2A   "ASIAN FAM HH: MAR COUP OWN KIDS (CONSTRUCT"
label variable XPHT3A   "ASIAN FAM HH: MAR COUP NO KIDS (CONSTRUCTE"
label variable XPHT4A   "ASIAN FAM HH: MALE HEAD OWN KIDS (CONSTRUC"
label variable XPHT5A   "ASIAN FAM HH: MALE HEAD NO KIDS (CONSTRUCT"
label variable XPHT6A   "ASIAN FAM HH: FEM HEAD OWN KIDS (CONSTRUCT"
label variable XPHT7A   "ASIAN FAM HH: FEM HEAD NO KIDS (CONSTRUCTE"
label variable XPHT8A   "ASIAN NON FAM HH: ALONE (CONSTRUCTED)"
label variable XPHT9A   "ASIAN NON FAM HH: WITH OTHERS (CONSTRUCTED"
label variable XPHHO    "OTHER HOUSHOLDS (P146F001)"
label variable XPHT1O   "OTHER FAMILY HH (CONSTRUCTED)"
label variable XPHT2O   "OTHER FAM HH: MAR COUP OWN KIDS (CONSTRUCT"
label variable XPHT3O   "OTHER FAM HH: MAR COUP NO KIDS (CONSTRUCTE"
label variable XPHT4O   "OTHER FAM HH: MALE HEAD OWN KIDS (CONSTRUC"
label variable XPHT5O   "OTHER FAM HH: MALE HEAD NO KIDS (CONSTRUCT"
label variable XPHT6O   "OTHER FAM HH: FEM HEAD OWN KIDS (CONSTRUCT"
label variable XPHT7O   "OTHER FAM HH: FEM HEAD NO KIDS (CONSTRUCTE"
label variable XPHT8O   "OTHER NON FAM HH: ALONE (CONSTRUCTED)"
label variable XPHT9O   "OTHER NON FAM HH: WITH OTHERS (CONSTRUCTED"
label variable XPHHM    "MULTI HOUSHOLDS (P146G001)"
label variable XPHT1M   "MULTI FAMILY HH (CONSTRUCTED)"
label variable XPHT2M   "MULTI FAM HH: MAR COUP OWN KIDS (CONSTRUCT"
label variable XPHT3M   "MULTI FAM HH: MAR COUP NO KIDS (CONSTRUCTE"
label variable XPHT4M   "MULTI FAM HH: MALE HEAD OWN KIDS (CONSTRUC"
label variable XPHT5M   "MULTI FAM HH: MALE HEAD NO KIDS (CONSTRUCT"
label variable XPHT6M   "MULTI FAM HH: FEM HEAD OWN KIDS (CONSTRUCT"
label variable XPHT7M   "MULTI FAM HH: FEM HEAD NO KIDS (CONSTRUCTE"
label variable XPHT8M   "MULTI NON FAM HH: ALONE (CONSTRUCTED)"
label variable XPHT9M   "MULTI NON FAM HH: WITH MULTIS (CONSTRUCTED"
label variable XPHHH    "HISP HOUSHOLDS (P146H001)"
label variable XPHT1H   "HISP FAMILY HH (CONSTRUCTED)"
label variable XPHT2H   "HISP FAM HH: MAR COUP OWN KIDS (CONSTRUCTE"
label variable XPHT3H   "HISP FAM HH: MAR COUP NO KIDS (CONSTRUCTED"
label variable XPHT4H   "HISP FAM HH: MALE HEAD OWN KIDS (CONSTRUCT"
label variable XPHT5H   "HISP FAM HH: MALE HEAD NO KIDS (CONSTRUCTE"
label variable XPHT6H   "HISP FAM HH: FEM HEAD OWN KIDS (CONSTRUCTE"
label variable XPHT7H   "HISP FAM HH: FEM HEAD NO KIDS (CONSTRUCTED"
label variable XPHT8H   "HISP NON FAM HH: ALONE (CONSTRUCTED)"
label variable XPHT9H   "HISP NON FAM HH: WITH HISPS (CONSTRUCTED)"
label variable XPHHN    "NH WHITE HOUSHOLDS (P146I001)"
label variable XPHT1N   "NH WHITE FAMILY HH (CONSTRUCTED)"
label variable XPHT2N   "NH WHITE FAM HH: MAR COUP OWN KIDS (CONSTR"
label variable XPHT3N   "NH WHITE FAM HH: MAR COUP NO KIDS (CONSTRU"
label variable XPHT4N   "NH WHITE FAM HH: MALE HEAD OWN KIDS (CONST"
label variable XPHT5N   "NH WHITE FAM HH: MALE HEAD NO KIDS (CONSTR"
label variable XPHT6N   "NH WHITE FAM HH: FEM HEAD OWN KIDS (CONSTR"
label variable XPHT7N   "NH WHITE FAM HH: FEM HEAD NO KIDS (CONSTRU"
label variable XPHT8N   "NH WHITE NON FAM HH: ALONE (CONSTRUCTED)"
label variable XPHT9N   "NH WHITE NON FAM HH: WITH NH WHITES (CONST"
label variable XPFP1    "FAMILIES   (P0900001)"
label variable XPFP2    "FAMILIES WITH REL KIDS (CONSTRUCTED)"
label variable XPFP3    "FAM WITH REL KIDS BELOW POV (CONSTRUCTED)"
label variable XPFP1W   "WHITE FAMILIES   (P160A001))"
label variable XPFP2W   "WHITE FAMILIES WITH REL KIDS (CONSTRUCTED)"
label variable XPFP3W   "WHITE FAM WITH REL KIDS BELOW POV (CONSTRU"
label variable XPFP1B   "BLACK FAMILIES  (P160B001)"
label variable XPFP2B   "BLACK FAMILIES WITH REL KIDS (CONSTRUCTED)"
label variable XPFP3B   "BLACK FAM WITH REL KIDS BELOW POV (CONSTRU"
label variable XPFP1I   "AMINF FAMILIES (P160C001)"
label variable XPFP2I   "AMIND FAMILIES WITH REL KIDS (CONSTRUCTED)"
label variable XPFP3I   "AMIND FAM WITH REL KIDS BELOW POV (CONSTRU"
label variable XPFP1A   "ASIAN FAMILIES  (CONSTRUCTED)"
label variable XPFP2A   "ASIAN FAMILIES WITH REL KIDS (CONSTRUCTED)"
label variable XPFP3A   "ASIAN FAM WITH REL KIDS BELOW POV (CONSTRU"
label variable XPFP1O   "OTHER FAMILIES (P160F001)"
label variable XPFP2O   "OTHER FAMILIES WITH REL KIDS (CONSTRUCTED)"
label variable XPFP3O   "OTHER FAM WITH REL KIDS BELOW POV (CONSTRU"
label variable XPFP1M   "MULTI FAMILIES (P160G001)"
label variable XPFP2M   "MULTI FAMILIES WITH REL KIDS (CONSTRUCTED)"
label variable XPFP3M   "MULTI FAM WITH REL KIDS BELOW POV (CONSTRU"
label variable XPFP1H   "HISPANIC FAMILIES (P160H001)"
label variable XPFP2H   "HISP FAMILIES WITH REL KIDS (CONSTRUCTED)"
label variable XPFP3H   "HISP FAM WITH REL KIDS BELOW POV (CONSTRUC"
label variable XPFP1N   "NH WHITE FAMILIES (P160I001)"
label variable XPFP2N   "NH WHITE FAMILIES WITH REL KIDS (CONSTRUCT"
label variable XPFP3N   "NH WHITE FAM WITH REL KIDS BELOW POV (CONS"
label variable XHTP1    "POP IN HOUSING UNITS (H0150001)"
label variable XHHU     "TOTAL HOUSING UNITS (H0010001)"
label variable XHTN1    "OCCUPIED HU (H0070001)"
label variable XHTN2    "OWN OCC HU (H0070002)"
label variable XHTN3    "RENT OCC HU (H0070003)"
label variable XHTB1    "TYPE BLDG: SINGLE FAM (CONSTRUCTED)"
label variable XHTB2    "TYPE BLDG: 2-4 UNITS (CONSTRUCTED)"
label variable XHTB3    "TYPE BLDG: 5-9 UNITS"
label variable XHTB4    "TYPE BLDG: 10-19 UNITS"
label variable XHTB5    "TYPE BLDG 20-49 UNITS"
label variable XHTB6    "TYPE BLDG: 50+ UNITS"
label variable XPPA1    "HH REC PUB ASSIST (P0640002)"
label variable X_PRA1   "% WHITE"
label variable X_PRA2   "% BLACK"
label variable X_PRA3   "% AMIND"
label variable X_PRA4   "% ASIAN"
label variable X_PRA5   "% OTHER"
label variable X_PRA6   "% MULTI"
label variable X_PHR1   "% HISP"
label variable X_PHR2   "% NH WHITE"
label variable X_PHR3   "% NH BLACK"
label variable X_PHR4   "% NH AMIND"
label variable X_PHR5   "% NH ASIAN"
label variable X_PHR6   "% NH OTHER"
label variable X_PHR7   "% NH MULTI"
label variable X_PHR8   "% HISP WHITE"
label variable X_PHR9   "% HISP BLACK"
label variable X_PHR10  "% HISP AMIND"
label variable X_PHR11  "% HISP ASIAN"
label variable X_PHR12  "% HISP OTHER"
label variable X_PHR13  "% HISP MULTI"
label variable X_POK2   "OWN KIDS 0-17: % IN MAR COUP FAM"
label variable X_POK3   "OWN KIDS 0-17: % IN MALE HEAD FAM"
label variable X_POK4   "OWN KIDS 0-17: % IN FEM HEAD FAM"
label variable X_POK6   "OWN KIDS AGE 0-2: % IN MAR COUP HH"
label variable X_POK7   "OWN KIDS AGE 0-2: % IN MALE HEAD HH"
label variable X_POK8   "OWN KIDS AGE 0-2: % IN FEM HEAD HH"
label variable X_POK10  "OWN KIDS AGE 3-5: % IN MAR COUP HH"
label variable X_POK11  "OWN KIDS AGE 3-5: % IN MALE HEAD HH"
label variable X_POK12  "OWN KIDS AGE 3-5: % IN FEM HEAD HH"
label variable X_POK14  "OWN KIDS 6-11: % IN MAR COUP FAM"
label variable X_POK15  "OWN KIDS 6-11: % IN MALE HEAD FAM"
label variable X_POK16  "OWN KIDS 6-11: % IN FEM HEAD FAM"
label variable X_POK18  "OWN KIDS 12-13: % IN MAR COUP FAM"
label variable X_POK19  "OWN KIDS 12-13: % IN MALE HEAD FAM"
label variable X_POK20  "OWN KIDS 12-13: % IN FEM HEAD FAM"
label variable X_POK22  "OWN KIDS AGE 14: % IN MAR COUP FAM"
label variable X_POK23  "OWN KIDS AGE 14: % IN MALE HEAD FAM"
label variable X_POK24  "OWN KIDS AGE 14: % IN FEM HEAD FAM"
label variable X_POK26  "OWN KIDS 15-17: % IN MAR COUP FAM"
label variable X_POK27  "OWN KIDS 15-17: % IN MALE HEAD FAM"
label variable X_POK28  "OWN KIDS 15-17: % IN FEM HEAD FAM"
label variable X_PSX1   "% MALE"
label variable X_PSX2   "% FEMALE"
label variable X_PMS2   "% AGE 15+: SINGLE"
label variable X_PMS3   "% AGE 15+: MARRIED"
label variable X_PMS4   "% AGE 15+: SEPARATED"
label variable X_PMS5   "% AGE 15+: WIDOWED"
label variable X_PMS6   "% AGE 15+: DIVORCED"
label variable X_PLI1   "% POP 5+ IN HH"
label variable X_PLI2   "% POP 5+: LING ISOLATED"
label variable X_PLI3   "% LING ISOLATED: AGE 5-17"
label variable X_PLI4   "% LING ISOLATED: AGE 18-44"
label variable X_PLI5   "% LING ISOLATED: AGE 45-64"
label variable X_PLI6   "% LING ISOLATED: AGE 65 +"
label variable X_PFB1   "% FOREIGN BORN"
label variable X_PPV2   "% PERSONS BELOW POV"
label variable X_PAG1   "% AGE 0-17"
label variable X_PAG2   "% AGE 65 +"
label variable X_PDO1   "% AGE 16-19"
label variable X_PDO2   "% CIV 16-19"
label variable X_PDO3   "% CIV 16-19: DROPOUT"
label variable X_PDO1W  "% AGE 16-19: WHITE"
label variable X_PDO2W  "% CIV 16-19: WHITE"
label variable X_PDO3W  "% CIV 16-19: WHITE DROPOUT"
label variable X_PDO1B  "% AGE 16-19: BLACK"
label variable X_PDO2B  "% CIV 16-19: BLACK"
label variable X_PDO3B  "% CIV 16-19: BLACK DROPOUT"
label variable X_PDO1I  "% AGE 16-19: AMIND"
label variable X_PDO2I  "% CIV 16-19: AMIND"
label variable X_PDO3I  "% CIV 16-19: AMIND DROPOUT"
label variable X_PDO1A  "% AGE 16-19: ASIAN"
label variable X_PDO2A  "% CIV 16-19: ASIAN"
label variable X_PDO3A  "% CIV 16-19: ASIAN DROPOUT"
label variable X_PDO1O  "% AGE 16-19: OTHER"
label variable X_PDO2O  "% CIV 16-19: OTHER"
label variable X_PDO3O  "% CIV 16-19: OTHER DROPOUT"
label variable X_PDO1M  "% AGE 16-19: MULTI"
label variable X_PDO2M  "% CIV 16-19: MULTI"
label variable X_PDO3M  "% CIV 16-19: MULTI DROPOUT"
label variable X_PDO1H  "% AGE 16-19: HISP"
label variable X_PDO2H  "% CIV 16-19: HISP"
label variable X_PDO3H  "% CIV 16-19: HISP DROPOUT"
label variable X_PDO1N  "% AGE 16-19: NH WHITE"
label variable X_PDO2N  "% CIV 16-19: NH WHITE"
label variable X_PDO3N  "% CIV 16-19: NH WHITE DROPOUT"
label variable X_POC2   "% OCC 16+: MAN/BUS/FIN"
label variable X_POC3   "% OCC 16+: PROF AND REL"
label variable X_POC4   "% OCC 16+: SERVICE"
label variable X_POC5   "% OCC 16+: SALES"
label variable X_POC6   "% OCC 16+: OFFICE/ADM SUP"
label variable X_POC7   "% OCC 16+: FOR/FARM/FISH"
label variable X_POC8   "% OCC 16+: CONSTR/EXTR/MAINT"
label variable X_POC9   "% OCC 16+: PROD/TRANS/MAT MOV"
label variable X_PLF1   "% AGE 16+"
label variable X_PLF2   "% AGE 16+: IN CIV LF"
label variable X_PLF3   "% AGE 16+: IN CIV LF: EMP"
label variable X_PLF4   "% AGE 16+: IN CIV LF: UNEMP"
label variable X_PLF5   "% AGE 16+: NILF"
label variable X_PLF6   "% AGE 16+: ARMY"
label variable X_PLF7   "% MALE 16+"
label variable X_PLF8   "% MALE 16+: IN CIV LF"
label variable X_PLF9   "% MALE 16+: IN CIV LF: EMP"
label variable X_PLF10  "% MALE 16+: IN CIV LF: UNEMP"
label variable X_PLF11  "% MALE 16+: NILF"
label variable X_PLF12  "% MALE 16+: ARMY"
label variable X_PLF13  "% FEM 16+"
label variable X_PLF14  "% FEM 16+: IN CIV LF"
label variable X_PLF15  "% FEM 16+: IN CIV LF: EMP"
label variable X_PLF16  "% FEM 16+: IN CIV LF: UNEMP"
label variable X_PLF17  "% FEM 16+: NILF"
label variable X_PLF18  "% FEM 16+: ARMY"
label variable X_PCL1   "% EMP 16+: PRIV FOR PROFIT"
label variable X_PCL2   "% EMP 16+: PRIV NON PROFIT"
label variable X_PCL3   "% EMP 16+: LOCAL GOVT"
label variable X_PCL4   "% EMP 16+: STATE GOVT"
label variable X_PCL5   "% EMP 16+: FED GOVT"
label variable X_PCL6   "% EMP 16+: SELF EMP"
label variable X_PCL7   "% EMP 16+: UNPAID FAM WRKR"
label variable X_PED1   "% AGE 25+"
label variable X_PED2   "% AGE 25+: LESS THAN HS"
label variable X_PED3   "% AGE 25+: HS GRAD"
label variable X_PED4   "% AGE 25+: SOME COLLEGE"
label variable X_PED5   "% AGE 25+: BA DEGREE"
label variable X_PED6   "% AGE 25+: MA+ DEGREE"
label variable X_PED1W  "% AGE 25+ WHITE"
label variable X_PED2W  "% AGE 25+ WHITE: LESS THAN HS"
label variable X_PED3W  "% AGE 25+ WHITE: HS GRAD"
label variable X_PED4W  "% AGE 25+ WHITE: SOME COLLEGE"
label variable X_PED5W  "% AGE 25+ WHITE: BA DEGREE"
label variable X_PED6W  "% AGE 25+ WHITE: MA+ DEGREE"
label variable X_PED1B  "% AGE 25+ BLACK"
label variable X_PED2B  "% AGE 25+ BLACK: LESS THAN HS"
label variable X_PED3B  "% AGE 25+ BLACK: HS GRAD"
label variable X_PED4B  "% AGE 25+ BLACK: SOME COLLEGE"
label variable X_PED5B  "% AGE 25+ BLACK: BA DEGREE"
label variable X_PED6B  "% AGE 25+ BLACK: MA+ DEGREE"
label variable X_PED1I  "% AGE 25+ AMIND"
label variable X_PED2I  "% AGE 25+ AMIND: LESS THAN HS"
label variable X_PED3I  "% AGE 25+ AMIND: HS GRAD"
label variable X_PED4I  "% AGE 25+ AMIND: SOME COLLEGE"
label variable X_PED5I  "% AGE 25+ AMIND: BA DEGREE"
label variable X_PED6I  "% AGE 25+ AMIND: MA+ DEGREE"
label variable X_PED1A  "% AGE 25+ ASIAN"
label variable X_PED2A  "% AGE 25+ ASIAN: LESS THAN HS"
label variable X_PED3A  "% AGE 25+ ASIAN: HS GRAD"
label variable X_PED4A  "% AGE 25+ ASIAN: SOME COLLEGE"
label variable X_PED5A  "% AGE 25+ ASIAN: BA DEGREE"
label variable X_PED6A  "% AGE 25+ ASIAN: MA+ DEGREE"
label variable X_PED1O  "% AGE 25+ OTHER"
label variable X_PED2O  "% AGE 25+ OTHER: LESS THAN HS"
label variable X_PED3O  "% AGE 25+ OTHER: HS GRAD"
label variable X_PED4O  "% AGE 25+ OTHER: SOME COLLEGE"
label variable X_PED5O  "% AGE 25+ OTHER: BA DEGREE"
label variable X_PED6O  "% AGE 25+ OTHER: MA+ DEGREE"
label variable X_PED1M  "% AGE 25+ MULTI"
label variable X_PED2M  "% AGE 25+ MULTI: LESS THAN HS"
label variable X_PED3M  "% AGE 25+ MULTI: HS GRAD"
label variable X_PED4M  "% AGE 25+ MULTI: SOME COLLEGE"
label variable X_PED5M  "% AGE 25+ MULTI: BA DEGREE"
label variable X_PED6M  "% AGE 25+ MULTI: MA+ DEGREE"
label variable X_PED1H  "% AGE 25+ HISP"
label variable X_PED2H  "% AGE 25+ HISP: LESS THAN HS"
label variable X_PED3H  "% AGE 25+ HISP: HS GRAD"
label variable X_PED4H  "% AGE 25+ HISP: SOME COLLEGE"
label variable X_PED5H  "% AGE 25+ HISP: BA DEGREE"
label variable X_PED6H  "% AGE 25+ HISP: MA+ DEGREE"
label variable X_PED1N  "% AGE 25+ NH WHITE"
label variable X_PED2N  "% AGE 25+ NH WHITE: LESS THAN HS"
label variable X_PED3N  "% AGE 25+ NH WHITE: HS GRAD"
label variable X_PED4N  "% AGE 25+ NH WHITE: SOME COLLEGE"
label variable X_PED5N  "% AGE 25+ NH WHITE: BA DEGREE"
label variable X_PED6N  "% AGE 25+ NH WHITE: MA+ DEGREE"
label variable X_PHT1   "% FAMILY HH"
label variable X_PHT2   "% FAM HH: MAR COUP OWN KIDS"
label variable X_PHT3   "% FAM HH: MAR COUP NO KIDS"
label variable X_PHT4   "% FAM HH: MALE HEAD OWN KIDS"
label variable X_PHT5   "% FAM HH: MALE HEAD NO KIDS"
label variable X_PHT6   "% FAM HH: FEM HEAD OWN KIDS"
label variable X_PHT7   "% FAM HH: FEM HEAD NO KIDS"
label variable X_PHT8   "% NON FAM HH: ALONE"
label variable X_PHT9   "% NON FAM HH: WITH OTHERS"
label variable X_PHHW   "% WHITE HOUSHOLDS"
label variable X_PHT1W  "% WHITE FAMILY HH"
label variable X_PHT2W  "% WHITE FAM HH: MAR COUP OWN KIDS"
label variable X_PHT3W  "% WHITE FAM HH: MAR COUP NO KIDS"
label variable X_PHT4W  "% WHITE FAM HH: MALE HEAD OWN KIDS"
label variable X_PHT5W  "% WHITE FAM HH: MALE HEAD NO KIDS"
label variable X_PHT6W  "% WHITE FAM HH: FEM HEAD OWN KIDS"
label variable X_PHT7W  "% WHITE FAM HH: FEM HEAD NO KIDS"
label variable X_PHT8W  "% WHITE NON FAM HH: ALONE"
label variable X_PHT9W  "% WHITE NON FAM HH: WITH OTHERS"
label variable X_PHHB   "% BLACK HOUSHOLDS"
label variable X_PHT1B  "% BLACK FAMILY HH"
label variable X_PHT2B  "% BLACK FAM HH: MAR COUP OWN KIDS"
label variable X_PHT3B  "% BLACK FAM HH: MAR COUP NO KIDS"
label variable X_PHT4B  "% BLACK FAM HH: MALE HEAD OWN KIDS"
label variable X_PHT5B  "% BLACK FAM HH: MALE HEAD NO KIDS"
label variable X_PHT6B  "% BLACK FAM HH: FEM HEAD OWN KIDS"
label variable X_PHT7B  "% BLACK FAM HH: FEM HEAD NO KIDS"
label variable X_PHT8B  "% BLACK NON FAM HH: ALONE"
label variable X_PHT9B  "% BLACK NON FAM HH: WITH OTHERS"
label variable X_PHHI   "% AMIND HOUSHOLDS"
label variable X_PHT1I  "% AMIND FAMILY HH"
label variable X_PHT2I  "% AMIND FAM HH: MAR COUP OWN KIDS"
label variable X_PHT3I  "% AMIND FAM HH: MAR COUP NO KIDS"
label variable X_PHT4I  "% AMIND FAM HH: MALE HEAD OWN KIDS"
label variable X_PHT5I  "% AMIND FAM HH: MALE HEAD NO KIDS"
label variable X_PHT6I  "% AMIND FAM HH: FEM HEAD OWN KIDS"
label variable X_PHT7I  "% AMIND FAM HH: FEM HEAD NO KIDS"
label variable X_PHT8I  "% AMIND NON FAM HH: ALONE"
label variable X_PHT9I  "% AMIND NON FAM HH: WITH OTHERS"
label variable X_PHHA   "% ASIAN HOUSHOLDS"
label variable X_PHT1A  "% ASIAN FAMILY HH"
label variable X_PHT2A  "% ASIAN FAM HH: MAR COUP OWN KIDS"
label variable X_PHT3A  "% ASIAN FAM HH: MAR COUP NO KIDS"
label variable X_PHT4A  "% ASIAN FAM HH: MALE HEAD OWN KIDS"
label variable X_PHT5A  "% ASIAN FAM HH: MALE HEAD NO KIDS"
label variable X_PHT6A  "% ASIAN FAM HH: FEM HEAD OWN KIDS"
label variable X_PHT7A  "% ASIAN FAM HH: FEM HEAD NO KIDS"
label variable X_PHT8A  "% ASIAN NON FAM HH: ALONE"
label variable X_PHT9A  "% ASIAN NON FAM HH: WITH OTHERS"
label variable X_PHHO   "% OTHER HOUSHOLDS"
label variable X_PHT1O  "% OTHER FAMILY HH"
label variable X_PHT2O  "% OTHER FAM HH: MAR COUP OWN KIDS"
label variable X_PHT3O  "% OTHER FAM HH: MAR COUP NO KIDS"
label variable X_PHT4O  "% OTHER FAM HH: MALE HEAD OWN KIDS"
label variable X_PHT5O  "% OTHER FAM HH: MALE HEAD NO KIDS"
label variable X_PHT6O  "% OTHER FAM HH: FEM HEAD OWN KIDS"
label variable X_PHT7O  "% OTHER FAM HH: FEM HEAD NO KIDS"
label variable X_PHT8O  "% OTHER NON FAM HH: ALONE"
label variable X_PHT9O  "% OTHER NON FAM HH: WITH OTHERS"
label variable X_PHHM   "% MULTI HOUSHOLDS"
label variable X_PHT1M  "% MULTI FAMILY HH"
label variable X_PHT2M  "% MULTI FAM HH: MAR COUP OWN KIDS"
label variable X_PHT3M  "% MULTI FAM HH: MAR COUP NO KIDS"
label variable X_PHT4M  "% MULTI FAM HH: MALE HEAD OWN KIDS"
label variable X_PHT5M  "% MULTI FAM HH: MALE HEAD NO KIDS"
label variable X_PHT6M  "% MULTI FAM HH: FEM HEAD OWN KIDS"
label variable X_PHT7M  "% MULTI FAM HH: FEM HEAD NO KIDS"
label variable X_PHT8M  "% MULTI NON FAM HH: ALONE"
label variable X_PHT9M  "% MULTI NON FAM HH: WITH OTHERS"
label variable X_PHHH   "% HISP HOUSHOLDS"
label variable X_PHT1H  "% HISP FAMILY HH"
label variable X_PHT2H  "% HISP FAM HH: MAR COUP OWN KIDS"
label variable X_PHT3H  "% HISP FAM HH: MAR COUP NO KIDS"
label variable X_PHT4H  "% HISP FAM HH: MALE HEAD OWN KIDS"
label variable X_PHT5H  "% HISP FAM HH: MALE HEAD NO KIDS"
label variable X_PHT6H  "% HISP FAM HH: FEM HEAD OWN KIDS"
label variable X_PHT7H  "% HISP FAM HH: FEM HEAD NO KIDS"
label variable X_PHT8H  "% HISP NON FAM HH: ALONE"
label variable X_PHT9H  "% HISP NON FAM HH: WITH OTHERS"
label variable X_PHHN   "% NH WHITE HOUSHOLDS"
label variable X_PHT1N  "% NH WHITE FAMILY HH"
label variable X_PHT2N  "% NH WHITE FAM HH: MAR COUP OWN KIDS"
label variable X_PHT3N  "% NH WHITE FAM HH: MAR COUP NO KIDS"
label variable X_PHT4N  "% NH WHITE FAM HH: MALE HEAD OWN KIDS"
label variable X_PHT5N  "% NH WHITE FAM HH: MALE HEAD NO KIDS"
label variable X_PHT6N  "% NH WHITE FAM HH: FEM HEAD OWN KIDS"
label variable X_PHT7N  "% NH WHITE FAM HH: FEM HEAD NO KIDS"
label variable X_PHT8N  "% NH WHITE NON FAM HH: ALONE"
label variable X_PHT9N  "% NH WHITE NON FAM HH: WITH OTHERS"
label variable X_PFP1   "% FAMILY HOUSHOLDS"
label variable X_PFP2   "% FAMILIES WITH REL KIDS"
label variable X_PFP3   "% FAM WITH REL KIDS BELOW POV"
label variable X_PFP1W  "% WHITE FAMILY HOUSHOLDS"
label variable X_PFP2W  "% WHITE FAMILIES WITH REL KIDS"
label variable X_PFP3W  "% WHITE FAM WITH REL KIDS BELOW POV"
label variable X_PFP1B  "% BLACK FAMILY HOUSHOLDS"
label variable X_PFP2B  "% BLACK FAMILIES WITH REL KIDS"
label variable X_PFP3B  "% BLACK FAM WITH REL KIDS BELOW POV"
label variable X_PFP1I  "% AMIND FAMILY HOUSHOLDS"
label variable X_PFP2I  "% AMIND FAMILIES WITH REL KIDS"
label variable X_PFP3I  "% AMIND FAM WITH REL KIDS BELOW POV"
label variable X_PFP1A  "% ASIAN FAMILY HOUSHOLDS"
label variable X_PFP2A  "% ASIAN FAMILIES WITH REL KIDS"
label variable X_PFP3A  "% ASIAN FAM WITH REL KIDS BELOW POV"
label variable X_PFP1O  "% OTHER FAMILY HOUSHOLDS"
label variable X_PFP2O  "% OTHER FAMILIES WITH REL KIDS"
label variable X_PFP3O  "% OTHER FAM WITH REL KIDS BELOW POV"
label variable X_PFP1M  "% MULTI FAMILY HOUSHOLDS"
label variable X_PFP2M  "% MULTI FAMILIES WITH REL KIDS"
label variable X_PFP3M  "% MULTI FAM WITH REL KIDS BELOW POV"
label variable X_PFP1H  "% HISP FAMILY HOUSHOLDS"
label variable X_PFP2H  "% HISP FAMILIES WITH REL KIDS"
label variable X_PFP3H  "% HISP FAM WITH REL KIDS BELOW POV"
label variable X_PFP1N  "% NH WHITE FAMILY HOUSHOLDS"
label variable X_PFP2N  "% NH WHITE FAMILIES WITH REL KIDS"
label variable X_PFP3N  "% NH WHITE FAM WITH REL KIDS BELOW POV"
label variable X_PPA1   "% HH REC PUB ASSIST"
label variable X_HTP1   "% POP IN HOUSING UNTIS"
label variable X_HTN1   "% OCCUPIED HU"
label variable X_HTN2   "% OWN OCC HU"
label variable X_HTN3   "% RENT OCC HU"
label variable X_HTB1   "% TYPE BLDG: SINGLE FAM"
label variable X_HTB2   "% TYPE BLDG: 2-4 UNITS"
label variable X_HTB3   "% TYPE BLDG: 5-9 UNITS"
label variable X_HTB4   "% TYPE BLDG: 10-19 UNITS"
label variable X_HTB5   "% TYPE BLDG 20-49 UNITS"
label variable X_HTB6   "% TYPE BLDG: 50+ UNITS"

save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Restricted\Geocode\tracts.dta", replace

// Zctas

#delimit ;

infix
str ZCTA5    1-5      
ZHMD1        6-12     
ZHMD2        13-19    
ZHMD3        20-26    
ZPMD1        27-33    
ZPMD1W       34-40    
ZPMD1B       41-47    
ZPMD1I       48-54    
ZPMD1A       55-61    
ZPMD1O       62-68    
ZPMD1M       69-75    
ZPMD1H       76-82    
ZPMD1N       83-89    
ZPMD2        90-96    
ZPMD3        97-103   
ZPAV1        104-110  
ZPAV1W       111-117  
ZPAV1B       118-124  
ZPAV1I       125-131  
ZPAV1A       132-138  
ZPAV1O       139-145  
ZPAV1M       146-152  
ZPAV1H       153-159  
ZPAV1N       160-166  
ZAR1         167-173     
ZAR2         174-184  
ZPTP1        185-195  
ZPRA1        196-206  
ZPRA2        207-217  
ZPRA3        218-228  
ZPRA4        229-239  
ZPRA5        240-250  
ZPRA6        251-261  
ZPHR1        262-272  
ZPHR2        273-283  
ZPHR3        284-294  
ZPHR4        295-305  
ZPHR5        306-316  
ZPHR6        317-327  
ZPHR7        328-338  
ZPHR8        339-349  
ZPHR9        350-360  
ZPHR10       361-371  
ZPHR11       372-382  
ZPHR12       383-393  
ZPHR13       394-404  
ZPSX1        405-415  
ZPSX2        416-426  
ZPOK1        427-437  
ZPOK2        438-448  
ZPOK3        449-459  
ZPOK4        460-470  
ZPOK5        471-481  
ZPOK6        482-492  
ZPOK7        493-503  
ZPOK8        504-514  
ZPOK9        515-525  
ZPOK10       526-536  
ZPOK11       537-547  
ZPOK12       548-558  
ZPOK13       559-569  
ZPOK14       570-580  
ZPOK15       581-591  
ZPOK16       592-602  
ZPOK17       603-613  
ZPOK18       614-624  
ZPOK19       625-635  
ZPOK20       636-646  
ZPOK21       647-657  
ZPOK22       658-668  
ZPOK23       669-679  
ZPOK24       680-690  
ZPOK25       691-701  
ZPOK26       702-712  
ZPOK27       713-723  
ZPOK28       724-734  
ZPMS1        735-745  
ZPMS2        746-756  
ZPMS3        757-767  
ZPMS4        768-778  
ZPMS5        779-789  
ZPMS6        790-800  
ZPLI1        801-811  
ZPLI2        812-822  
ZPLI3        823-833  
ZPLI4        834-844  
ZPLI5        845-855  
ZPLI6        856-866  
ZPFB1        867-877  
ZPAG1        878-888  
ZPAG2        889-899  
ZPPV1        900-910  
ZPPV2        911-921  
ZPDO1        922-932  
ZPDO2        933-943  
ZPDO3        944-954  
ZPDO1W       955-965  
ZPDO2W       966-976  
ZPDO3W       977-987  
ZPDO1B       988-998  
ZPDO2B       999-1009 
ZPDO3B       1010-1020
ZPDO1I       1021-1031
ZPDO2I       1032-1042
ZPDO3I       1043-1053
ZPDO1A       1054-1064
ZPDO2A       1065-1075
ZPDO3A       1076-1086
ZPDO1O       1087-1097
ZPDO2O       1098-1108
ZPDO3O       1109-1119
ZPDO1M       1120-1130
ZPDO2M       1131-1141
ZPDO3M       1142-1152
ZPDO1H       1153-1163
ZPDO2H       1164-1174
ZPDO3H       1175-1185
ZPDO1N       1186-1196
ZPDO2N       1197-1207
ZPDO3N       1208-1218
ZPOC1        1219-1229
ZPOC2        1230-1240
ZPOC3        1241-1251
ZPOC4        1252-1262
ZPOC5        1263-1273
ZPOC6        1274-1284
ZPOC7        1285-1295
ZPOC8        1296-1306
ZPOC9        1307-1317
ZPLF1        1318-1328
ZPLF2        1329-1339
ZPLF3        1340-1350
ZPLF4        1351-1361
ZPLF5        1362-1372
ZPLF6        1373-1383
ZPLF7        1384-1394
ZPLF8        1395-1405
ZPLF9        1406-1416
ZPLF10       1417-1427
ZPLF11       1428-1438
ZPLF12       1439-1449
ZPLF13       1450-1460
ZPLF14       1461-1471
ZPLF15       1472-1482
ZPLF16       1483-1493
ZPLF17       1494-1504
ZPLF18       1505-1515
ZPCL1        1516-1526
ZPCL2        1527-1537
ZPCL3        1538-1548
ZPCL4        1549-1559
ZPCL5        1560-1570
ZPCL6        1571-1581
ZPCL7        1582-1592
ZPED1        1593-1603
ZPED2        1604-1614
ZPED3        1615-1625
ZPED4        1626-1636
ZPED5        1637-1647
ZPED6        1648-1658
ZPED1W       1659-1669
ZPED2W       1670-1680
ZPED3W       1681-1691
ZPED4W       1692-1702
ZPED5W       1703-1713
ZPED6W       1714-1724
ZPED1B       1725-1735
ZPED2B       1736-1746
ZPED3B       1747-1757
ZPED4B       1758-1768
ZPED5B       1769-1779
ZPED6B       1780-1790
ZPED1I       1791-1801
ZPED2I       1802-1812
ZPED3I       1813-1823
ZPED4I       1824-1834
ZPED5I       1835-1845
ZPED6I       1846-1856
ZPED1A       1857-1867
ZPED2A       1868-1878
ZPED3A       1879-1889
ZPED4A       1890-1900
ZPED5A       1901-1911
ZPED6A       1912-1922
ZPED1O       1923-1933
ZPED2O       1934-1944
ZPED3O       1945-1955
ZPED4O       1956-1966
ZPED5O       1967-1977
ZPED6O       1978-1988
ZPED1M       1989-1999
ZPED2M       2000-2010
ZPED3M       2011-2021
ZPED4M       2022-2032
ZPED5M       2033-2043
ZPED6M       2044-2054
ZPED1H       2055-2065
ZPED2H       2066-2076
ZPED3H       2077-2087
ZPED4H       2088-2098
ZPED5H       2099-2109
ZPED6H       2110-2120
ZPED1N       2121-2131
ZPED2N       2132-2142
ZPED3N       2143-2153
ZPED4N       2154-2164
ZPED5N       2165-2175
ZPED6N       2176-2186
ZPHH         2187-2197
ZPHT1        2198-2208
ZPHT2        2209-2219
ZPHT3        2220-2230
ZPHT4        2231-2241
ZPHT5        2242-2252
ZPHT6        2253-2263
ZPHT7        2264-2274
ZPHT8        2275-2285
ZPHT9        2286-2296
ZPHHW        2297-2307
ZPHT1W       2308-2318
ZPHT2W       2319-2329
ZPHT3W       2330-2340
ZPHT4W       2341-2351
ZPHT5W       2352-2362
ZPHT6W       2363-2373
ZPHT7W       2374-2384
ZPHT8W       2385-2395
ZPHT9W       2396-2406
ZPHHB        2407-2417
ZPHT1B       2418-2428
ZPHT2B       2429-2439
ZPHT3B       2440-2450
ZPHT4B       2451-2461
ZPHT5B       2462-2472
ZPHT6B       2473-2483
ZPHT7B       2484-2494
ZPHT8B       2495-2505
ZPHT9B       2506-2516
ZPHHI        2517-2527
ZPHT1I       2528-2538
ZPHT2I       2539-2549
ZPHT3I       2550-2560
ZPHT4I       2561-2571
ZPHT5I       2572-2582
ZPHT6I       2583-2593
ZPHT7I       2594-2604
ZPHT8I       2605-2615
ZPHT9I       2616-2626
ZPHHA        2627-2637
ZPHT1A       2638-2648
ZPHT2A       2649-2659
ZPHT3A       2660-2670
ZPHT4A       2671-2681
ZPHT5A       2682-2692
ZPHT6A       2693-2703
ZPHT7A       2704-2714
ZPHT8A       2715-2725
ZPHT9A       2726-2736
ZPHHO        2737-2747
ZPHT1O       2748-2758
ZPHT2O       2759-2769
ZPHT3O       2770-2780
ZPHT4O       2781-2791
ZPHT5O       2792-2802
ZPHT6O       2803-2813
ZPHT7O       2814-2824
ZPHT8O       2825-2835
ZPHT9O       2836-2846
ZPHHM        2847-2857
ZPHT1M       2858-2868
ZPHT2M       2869-2879
ZPHT3M       2880-2890
ZPHT4M       2891-2901
ZPHT5M       2902-2912
ZPHT6M       2913-2923
ZPHT7M       2924-2934
ZPHT8M       2935-2945
ZPHT9M       2946-2956
ZPHHH        2957-2967
ZPHT1H       2968-2978
ZPHT2H       2979-2989
ZPHT3H       2990-3000
ZPHT4H       3001-3011
ZPHT5H       3012-3022
ZPHT6H       3023-3033
ZPHT7H       3034-3044
ZPHT8H       3045-3055
ZPHT9H       3056-3066
ZPHHN        3067-3077
ZPHT1N       3078-3088
ZPHT2N       3089-3099
ZPHT3N       3100-3110
ZPHT4N       3111-3121
ZPHT5N       3122-3132
ZPHT6N       3133-3143
ZPHT7N       3144-3154
ZPHT8N       3155-3165
ZPHT9N       3166-3176
ZPFP1        3177-3187
ZPFP2        3188-3198
ZPFP3        3199-3209
ZPFP1W       3210-3220
ZPFP2W       3221-3231
ZPFP3W       3232-3242
ZPFP1B       3243-3253
ZPFP2B       3254-3264
ZPFP3B       3265-3275
ZPFP1I       3276-3286
ZPFP2I       3287-3297
ZPFP3I       3298-3308
ZPFP1A       3309-3319
ZPFP2A       3320-3330
ZPFP3A       3331-3341
ZPFP1O       3342-3352
ZPFP2O       3353-3363
ZPFP3O       3364-3374
ZPFP1M       3375-3385
ZPFP2M       3386-3396
ZPFP3M       3397-3407
ZPFP1H       3408-3418
ZPFP2H       3419-3429
ZPFP3H       3430-3440
ZPFP1N       3441-3451
ZPFP2N       3452-3462
ZPFP3N       3463-3473
ZHTP1        3474-3484
ZHHU         3485-3495
ZHTN1        3496-3506
ZHTN2        3507-3517
ZHTN3        3518-3528
ZHTB1        3529-3539
ZHTB2        3540-3550
ZHTB3        3551-3561
ZHTB4        3562-3572
ZHTB5        3573-3583
ZHTB6        3584-3594
ZPPA1        3595-3605
Z_PRA1       3606-3612   
Z_PRA2       3613-3619   
Z_PRA3       3620-3626   
Z_PRA4       3627-3633   
Z_PRA5       3634-3640   
Z_PRA6       3641-3647   
Z_PHR1       3648-3654   
Z_PHR2       3655-3661   
Z_PHR3       3662-3668   
Z_PHR4       3669-3675   
Z_PHR5       3676-3682   
Z_PHR6       3683-3689   
Z_PHR7       3690-3696   
Z_PHR8       3697-3703   
Z_PHR9       3704-3710   
Z_PHR10      3711-3717   
Z_PHR11      3718-3724   
Z_PHR12      3725-3731   
Z_PHR13      3732-3738   
Z_POK2       3739-3745   
Z_POK3       3746-3752   
Z_POK4       3753-3759   
Z_POK6       3760-3766   
Z_POK7       3767-3773   
Z_POK8       3774-3780   
Z_POK10      3781-3787   
Z_POK11      3788-3794   
Z_POK12      3795-3801   
Z_POK14      3802-3808   
Z_POK15      3809-3815   
Z_POK16      3816-3822   
Z_POK18      3823-3829   
Z_POK19      3830-3836   
Z_POK20      3837-3843   
Z_POK22      3844-3850   
Z_POK23      3851-3857   
Z_POK24      3858-3864   
Z_POK26      3865-3871   
Z_POK27      3872-3878   
Z_POK28      3879-3885   
Z_PSX1       3886-3892   
Z_PSX2       3893-3899   
Z_PMS2       3900-3906   
Z_PMS3       3907-3913   
Z_PMS4       3914-3920   
Z_PMS5       3921-3927   
Z_PMS6       3928-3934   
Z_PLI1       3935-3941   
Z_PLI2       3942-3948   
Z_PLI3       3949-3955   
Z_PLI4       3956-3962   
Z_PLI5       3963-3969   
Z_PLI6       3970-3976   
Z_PFB1       3977-3983   
Z_PPV2       3984-3990   
Z_PAG1       3991-3997   
Z_PAG2       3998-4004   
Z_PDO1       4005-4011   
Z_PDO2       4012-4018   
Z_PDO3       4019-4025   
Z_PDO1W      4026-4032   
Z_PDO2W      4033-4039   
Z_PDO3W      4040-4046   
Z_PDO1B      4047-4053   
Z_PDO2B      4054-4060   
Z_PDO3B      4061-4067   
Z_PDO1I      4068-4074   
Z_PDO2I      4075-4081   
Z_PDO3I      4082-4088   
Z_PDO1A      4089-4095   
Z_PDO2A      4096-4102   
Z_PDO3A      4103-4109   
Z_PDO1O      4110-4116   
Z_PDO2O      4117-4123   
Z_PDO3O      4124-4130   
Z_PDO1M      4131-4137   
Z_PDO2M      4138-4144   
Z_PDO3M      4145-4151   
Z_PDO1H      4152-4158   
Z_PDO2H      4159-4165   
Z_PDO3H      4166-4172   
Z_PDO1N      4173-4179   
Z_PDO2N      4180-4186   
Z_PDO3N      4187-4193   
Z_POC2       4194-4200   
Z_POC3       4201-4207   
Z_POC4       4208-4214   
Z_POC5       4215-4221   
Z_POC6       4222-4228   
Z_POC7       4229-4235   
Z_POC8       4236-4242   
Z_POC9       4243-4249   
Z_PLF1       4250-4256   
Z_PLF2       4257-4263   
Z_PLF3       4264-4270   
Z_PLF4       4271-4277   
Z_PLF5       4278-4284   
Z_PLF6       4285-4291   
Z_PLF7       4292-4298   
Z_PLF8       4299-4305   
Z_PLF9       4306-4312   
Z_PLF10      4313-4319   
Z_PLF11      4320-4326   
Z_PLF12      4327-4333   
Z_PLF13      4334-4340   
Z_PLF14      4341-4347   
Z_PLF15      4348-4354   
Z_PLF16      4355-4361   
Z_PLF17      4362-4368   
Z_PLF18      4369-4375   
Z_PCL1       4376-4382   
Z_PCL2       4383-4389   
Z_PCL3       4390-4396   
Z_PCL4       4397-4403   
Z_PCL5       4404-4410   
Z_PCL6       4411-4417   
Z_PCL7       4418-4424   
Z_PED1       4425-4431   
Z_PED2       4432-4438   
Z_PED3       4439-4445   
Z_PED4       4446-4452   
Z_PED5       4453-4459   
Z_PED6       4460-4466   
Z_PED1W      4467-4473   
Z_PED2W      4474-4480   
Z_PED3W      4481-4487   
Z_PED4W      4488-4494   
Z_PED5W      4495-4501   
Z_PED6W      4502-4508   
Z_PED1B      4509-4515   
Z_PED2B      4516-4522   
Z_PED3B      4523-4529   
Z_PED4B      4530-4536   
Z_PED5B      4537-4543   
Z_PED6B      4544-4550   
Z_PED1I      4551-4557   
Z_PED2I      4558-4564   
Z_PED3I      4565-4571   
Z_PED4I      4572-4578   
Z_PED5I      4579-4585   
Z_PED6I      4586-4592   
Z_PED1A      4593-4599   
Z_PED2A      4600-4606   
Z_PED3A      4607-4613   
Z_PED4A      4614-4620   
Z_PED5A      4621-4627   
Z_PED6A      4628-4634   
Z_PED1O      4635-4641   
Z_PED2O      4642-4648   
Z_PED3O      4649-4655   
Z_PED4O      4656-4662   
Z_PED5O      4663-4669   
Z_PED6O      4670-4676   
Z_PED1M      4677-4683   
Z_PED2M      4684-4690   
Z_PED3M      4691-4697   
Z_PED4M      4698-4704   
Z_PED5M      4705-4711   
Z_PED6M      4712-4718   
Z_PED1H      4719-4725   
Z_PED2H      4726-4732   
Z_PED3H      4733-4739   
Z_PED4H      4740-4746   
Z_PED5H      4747-4753   
Z_PED6H      4754-4760   
Z_PED1N      4761-4767   
Z_PED2N      4768-4774   
Z_PED3N      4775-4781   
Z_PED4N      4782-4788   
Z_PED5N      4789-4795   
Z_PED6N      4796-4802   
Z_PHT1       4803-4809   
Z_PHT2       4810-4816   
Z_PHT3       4817-4823   
Z_PHT4       4824-4830   
Z_PHT5       4831-4837   
Z_PHT6       4838-4844   
Z_PHT7       4845-4851   
Z_PHT8       4852-4858   
Z_PHT9       4859-4865   
Z_PHHW       4866-4872   
Z_PHT1W      4873-4879   
Z_PHT2W      4880-4886   
Z_PHT3W      4887-4893   
Z_PHT4W      4894-4900   
Z_PHT5W      4901-4907   
Z_PHT6W      4908-4914   
Z_PHT7W      4915-4921   
Z_PHT8W      4922-4928   
Z_PHT9W      4929-4935   
Z_PHHB       4936-4942   
Z_PHT1B      4943-4949   
Z_PHT2B      4950-4956   
Z_PHT3B      4957-4963   
Z_PHT4B      4964-4970   
Z_PHT5B      4971-4977   
Z_PHT6B      4978-4984   
Z_PHT7B      4985-4991   
Z_PHT8B      4992-4998   
Z_PHT9B      4999-5005   
Z_PHHI       5006-5012   
Z_PHT1I      5013-5019   
Z_PHT2I      5020-5026   
Z_PHT3I      5027-5033   
Z_PHT4I      5034-5040   
Z_PHT5I      5041-5047   
Z_PHT6I      5048-5054   
Z_PHT7I      5055-5061   
Z_PHT8I      5062-5068   
Z_PHT9I      5069-5075   
Z_PHHA       5076-5082   
Z_PHT1A      5083-5089   
Z_PHT2A      5090-5096   
Z_PHT3A      5097-5103   
Z_PHT4A      5104-5110   
Z_PHT5A      5111-5117   
Z_PHT6A      5118-5124   
Z_PHT7A      5125-5131   
Z_PHT8A      5132-5138   
Z_PHT9A      5139-5145   
Z_PHHO       5146-5152   
Z_PHT1O      5153-5159   
Z_PHT2O      5160-5166   
Z_PHT3O      5167-5173   
Z_PHT4O      5174-5180   
Z_PHT5O      5181-5187   
Z_PHT6O      5188-5194   
Z_PHT7O      5195-5201   
Z_PHT8O      5202-5208   
Z_PHT9O      5209-5215   
Z_PHHM       5216-5222   
Z_PHT1M      5223-5229   
Z_PHT2M      5230-5236   
Z_PHT3M      5237-5243   
Z_PHT4M      5244-5250   
Z_PHT5M      5251-5257   
Z_PHT6M      5258-5264   
Z_PHT7M      5265-5271   
Z_PHT8M      5272-5278   
Z_PHT9M      5279-5285   
Z_PHHH       5286-5292   
Z_PHT1H      5293-5299   
Z_PHT2H      5300-5306   
Z_PHT3H      5307-5313   
Z_PHT4H      5314-5320   
Z_PHT5H      5321-5327   
Z_PHT6H      5328-5334   
Z_PHT7H      5335-5341   
Z_PHT8H      5342-5348   
Z_PHT9H      5349-5355   
Z_PHHN       5356-5362   
Z_PHT1N      5363-5369   
Z_PHT2N      5370-5376   
Z_PHT3N      5377-5383   
Z_PHT4N      5384-5390   
Z_PHT5N      5391-5397   
Z_PHT6N      5398-5404   
Z_PHT7N      5405-5411   
Z_PHT8N      5412-5418   
Z_PHT9N      5419-5425   
Z_PFP1       5426-5432   
Z_PFP2       5433-5439   
Z_PFP3       5440-5446   
Z_PFP1W      5447-5453   
Z_PFP2W      5454-5460   
Z_PFP3W      5461-5467   
Z_PFP1B      5468-5474   
Z_PFP2B      5475-5481   
Z_PFP3B      5482-5488   
Z_PFP1I      5489-5495   
Z_PFP2I      5496-5502   
Z_PFP3I      5503-5509   
Z_PFP1A      5510-5516   
Z_PFP2A      5517-5523   
Z_PFP3A      5524-5530   
Z_PFP1O      5531-5537   
Z_PFP2O      5538-5544   
Z_PFP3O      5545-5551   
Z_PFP1M      5552-5558   
Z_PFP2M      5559-5565   
Z_PFP3M      5566-5572   
Z_PFP1H      5573-5579   
Z_PFP2H      5580-5586   
Z_PFP3H      5587-5593   
Z_PFP1N      5594-5600   
Z_PFP2N      5601-5607   
Z_PFP3N      5608-5614   
Z_PPA1       5615-5621   
Z_HTP1       5622-5628   
Z_HTN1       5629-5635   
Z_HTN2       5636-5642   
Z_HTN3       5643-5649   
Z_HTB1       5650-5656   
Z_HTB2       5657-5663   
Z_HTB3       5664-5670   
Z_HTB4       5671-5677   
Z_HTB5       5678-5684   
Z_HTB6       5685-5691
using "C:\Users\wodtke\Desktop\ecls_k98\restricted\ECLS-K Census Data and Geocodes\zctas.dat", clear;

#delimit cr

label variable ZCTA5     "ZIPCODE TABULATION AREA 2000 CENSUS"
label variable ZHMD1     "MEDIAN RENT (H0630001 )"
label variable ZHMD2     "MED VALUE ALL OWN OCC (H0850001)"
label variable ZHMD3     "MEDIAN SEL MONTHLY OWN COSTS (CONSTRUCTED"
label variable ZPMD1     "MEDIAN HH INCOME (P0530001)"
label variable ZPMD1W    "MEDIAN HH INCOME: WHITE (P152A001)"
label variable ZPMD1B    "MEDIAN HH INCOME: BLACK (P152B001)"
label variable ZPMD1I    "MEDIAN HH INCOME: AMIND (P152C001)"
label variable ZPMD1A    "MEDIAN HH INCOME: ASIAN (CONSTRUCTED)"
label variable ZPMD1O    "MEDIAN HH INCOME: OTHER (P152F001)"
label variable ZPMD1M    "MEDIAN HH INCOME: MULTI (P152G001)"
label variable ZPMD1H    "MEDIAN HH INCOME: HISP (P152H001)"
label variable ZPMD1N    "MEDIAN HH INCOME: NH WHITE (P152I001)"
label variable ZPMD2     "MEDIAN FAM INC (P0770001)"
label variable ZPMD3     "MEDIAN NON FAMILY INCOME (P0800001)"
label variable ZPAV1     "AVG HH INCOME (CONSTRUCTED)"
label variable ZPAV1W    "AVG HH INCOME: WHITE (CONSTRUCTED)"
label variable ZPAV1B    "AVG HH INCOME: BLACK (CONSTRUCTED)"
label variable ZPAV1I    "AVG HH INCOME: AMIND (CONSTRUCTED)"
label variable ZPAV1A    "AVG HH INCOME: ASIAN (CONSTRUCTED)"
label variable ZPAV1O    "AVG HH INCOME: OTHER (CONSTRUCTED)"
label variable ZPAV1M    "AVG HH INCOME: MULTI (CONSTRUCTED)"
label variable ZPAV1H    "AVG HH INCOME: HISP (CONSTRUCTED)"
label variable ZPAV1N    "AVG HH INCOME: NH WHITE (CONSTRUCTED)"
label variable ZAR1      "LAND AREA  (CONSTRUCTED)"
label variable ZAR2      "POPULATION DENSITY (CONSTRUCTED)"
label variable ZPTP1     "TOTAL POP (P0060001)"
label variable ZPRA1     "WHITE  (P0060002)"
label variable ZPRA2     "BLACK  (P0060003)"
label variable ZPRA3     "AMIND  (P0060004)"
label variable ZPRA4     "ASIAN  (P0060005+P0060006)"
label variable ZPRA5     "OTHER  (P0060007)"
label variable ZPRA6     "MULTI RACE (P0060008)"
label variable ZPHR1     "HISP (P0070010)"
label variable ZPHR2     "NH WHITE (P0070003)"
label variable ZPHR3     "NH BLACK (P0070004)"
label variable ZPHR4     "NH AMIND (P0070005)"
label variable ZPHR5     "NH ASIAN (P0070006+P0070007)"
label variable ZPHR6     "NH OTHER (P0070008)"
label variable ZPHR7     "NH MULTI (P0070009)"
label variable ZPHR8     "HISP WHITE (P0070011)"
label variable ZPHR9     "HISP BLACK (P0070012)"
label variable ZPHR10    "HISP AMIND (P0070013)"
label variable ZPHR11    "HISP ASIAN (P0070014+P0070015)"
label variable ZPHR12    "HISP OTHER (P0070016)"
label variable ZPHR13    "HISP MULTI (P0070017)"
label variable ZPSX1     "MALE (P0080002)"
label variable ZPSX2     "FEMALE (P0080041)"
label variable ZPOK1     "OWN KIDS 0-17 (PERSONS)  (P0160001)"
label variable ZPOK2     "OWN KIDS 0-17: IN MAR COUP FAM (P0160002)"
label variable ZPOK3     "OWN KIDS 0-17: IN MALE HEAD FAM (P0160011)"
label variable ZPOK4     "OWN KIDS 0-17: IN FEM HEAD FAM  (P0160019)"
label variable ZPOK5     "OWN KIDS AGE 0-2 (CONSTRUCTED)"
label variable ZPOK6     "OWN KIDS AGE 0-2: IN MAR COUP HH (P0160003"
label variable ZPOK7     "OWN KIDS AGE 0-2: IN MALE HEAD HH (P016001"
label variable ZPOK8     "OWN KIDS AGE 0-2: IN FEM HEAD HH (P0160020"
label variable ZPOK9     "OWN KIDS AGE 3-5 (CONSTRUCTED)"
label variable ZPOK10    "OWN KIDS AGE 3-5: IN MAR COUP HH (CONSTRUC"
label variable ZPOK11    "OWN KIDS AGE 3-5: IN MALE HEAD HH (CONSTRU"
label variable ZPOK12    "OWN KIDS AGE 3-5: IN FEM HEAD HH (CONSTRUC"
label variable ZPOK13    "OWN KIDS 6-11 (CONSTRUCTED)"
label variable ZPOK14    "OWN KIDS 6-11: IN MAR COUP FAM (P0160006)"
label variable ZPOK15    "OWN KIDS 6-11: IN MALE HEAD FAM (P0160015)"
label variable ZPOK16    "OWN KIDS 6-11: IN FEM HEAD FAM (P0160023)"
label variable ZPOK17    "OWN KIDS 12-13 (CONSTRUCTED)"
label variable ZPOK18    "OWN KIDS 12-13: IN MAR COUP FAM (P0160007)"
label variable ZPOK19    "OWN KIDS 12-13: IN MALE HEAD FAM (P0160016"
label variable ZPOK20    "OWN KIDS 12-13: IN FEM HEAD FAM (P0160024)"
label variable ZPOK21    "OWN KIDS AGE 14 (CONSTRUCTED)"
label variable ZPOK22    "OWN KIDS AGE 14: IN MAR COUP FAM (P0160008"
label variable ZPOK23    "OWN KIDS AGE 14: IN MALE HEAD FAM (P016001"
label variable ZPOK24    "OWN KIDS AGE 14: IN FEM HEAD FAM (P0160025"
label variable ZPOK25    "OWN KIDS 15-17 (CONSTRUCTED)"
label variable ZPOK26    "OWN KIDS 15-17: IN MAR COUP FAM (P0160009)"
label variable ZPOK27    "OWN KIDS 15-17: IN MALE HEAD FAM (P0160018"
label variable ZPOK28    "OWN KIDS 15-17: IN FEM HEAD FAM (P0160026)"
label variable ZPMS1     "AGE 15+ (P0180001)"
label variable ZPMS2     "AGE 15+: SINGLE (CONSTRUCTED)"
label variable ZPMS3     "AGE 15+: MARRIED (CONSTRUCTED)"
label variable ZPMS4     "AGE 15+: SEPARATED (CONSTRUCTED)"
label variable ZPMS5     "AGE 15+: WIDOWED (CONSTRUCTED)"
label variable ZPMS6     "AGE 15+: DIVORCED (CONSTRUCTED)"
label variable ZPLI1     "POP 5+ IN HH"
label variable ZPLI2     "POP 5+: LING ISOLATED (CONSTRUCTED)"
label variable ZPLI3     "LING ISOLATED: AGE 5-17 (CONSTRUCTED)"
label variable ZPLI4     "LING ISOLATED: AGE 18-44 (CONSTRUCTED)"
label variable ZPLI5     "LING ISOLATED: AGE 45-64 (CONSTRUCTED)"
label variable ZPLI6     "LING ISOLATED: AGE 65 + (CONSTRUCTED)"
label variable ZPFB1     "FOREIGN BORN (P0210013)"
label variable ZPAG1     "AGE 0-17 (CONSTRUCTED)"
label variable ZPAG2     "AGE 65 + (CONSTRUCTED)"
label variable ZPPV1     "PERSONS POV STATUS DETERM (P0870001)"
label variable ZPPV2     "PERSONS BELOW POV (P0870002)"
label variable ZPDO1     "AGE 16-19 (P0380001)"
label variable ZPDO2     "CIV 16-19 (P0380009)"
label variable ZPDO3     "CIV 16-19: DROPOUT (P0380019)"
label variable ZPDO1W    "AGE 16-19: WHITE (P149A001)"
label variable ZPDO2W    "CIV 16-19: WHITE  (P149A009)"
label variable ZPDO3W    "CIV 16-19: WHITE DROPOUT (P149A019)"
label variable ZPDO1B    "AGE 16-19: BLACK (P149B001)"
label variable ZPDO2B    "CIV 16-19: BLACK (P149B009)"
label variable ZPDO3B    "CIV 16-19: BLACK DROPOUT (P149B019)"
label variable ZPDO1I    "AGE 16-19: AMIND (P149C001)"
label variable ZPDO2I    "CIV 16-19: AMIND (P149C009)"
label variable ZPDO3I    "CIV 16-19: AMIND DROPOUT (P149C019)"
label variable ZPDO1A    "AGE 16-19: ASIAN (CONSTRUCTED)"
label variable ZPDO2A    "CIV 16-19: ASIAN (CONSTRUCTED)"
label variable ZPDO3A    "CIV 16-19: ASIAN DROPOUT (CONSTRUCTED)"
label variable ZPDO1O    "AGE 16-19: OTHER (P149F001)"
label variable ZPDO2O    "CIV 16-19: OTHER (P149F009)"
label variable ZPDO3O    "CIV 16-19: OTHER DROPOUT (P149F019)"
label variable ZPDO1M    "AGE 16-19: MULTI (P149G001)"
label variable ZPDO2M    "CIV 16-19: MULTI (P149G009)"
label variable ZPDO3M    "CIV 16-19: MULTI DROPOUT (P149G019)"
label variable ZPDO1H    "AGE 16-19: HISP (P149H001)"
label variable ZPDO2H    "CIV 16-19: HISP (P149H009)"
label variable ZPDO3H    "CIV 16-19: HISP DROPOUT (P149H019)"
label variable ZPDO1N    "AGE 16-19: NH WHITE (P149I001)"
label variable ZPDO2N    "CIV 16-19: NH WHITE (P149I009)"
label variable ZPDO3N    "CIV 16-19: NH WHITE DROPOUT (P149I019)"
label variable ZPOC1     "AGE 16+ EMP (P0500001)"
label variable ZPOC2     "OCC 16+: MAN/BUS/FIN (CONSTRUCTED)"
label variable ZPOC3     "OCC 16+: PROF AND REL (CONSTRUCTED)"
label variable ZPOC4     "OCC 16+: SERVICE (CONSTRUCTED)"
label variable ZPOC5     "OCC 16+: SALES (CONSTRUCTED)"
label variable ZPOC6     "OCC 16+: OFFICE/ADM SUP (CONSTRUCTED)"
label variable ZPOC7     "OCC 16+: FOR/FARM/FISH (CONSTRUCTED)"
label variable ZPOC8     "OCC 16+: CONSTR/EXTR/MAINT (CONSTRUCTED)"
label variable ZPOC9     "OCC 16+: PROD/TRANS/MAT MOV (CONSTRUCTED)"
label variable ZPLF1     "AGE 16+ (P0430001)"
label variable ZPLF2     "AGE 16+: IN CIV LF (CONSTRUCTED)"
label variable ZPLF3     "AGE 16+: IN CIV LF: EMP (CONSTRUCTED)"
label variable ZPLF4     "AGE 16+: IN CIV LF: UNEMP (CONSTRUCTED)"
label variable ZPLF5     "AGE 16+: NILF (CONSTRUCTED)"
label variable ZPLF6     "AGE 16+: ARMY (CONSTRUCTED)"
label variable ZPLF7     "MALE 16+ (P0430002)"
label variable ZPLF8     "MALE 16+: IN CIV LF (P0430005)"
label variable ZPLF9     "MALE 16+: IN CIV LF: EMP (P0430006)"
label variable ZPLF10    "MALE 16+: IN CIV LF: UNEMP (P0430007)"
label variable ZPLF11    "MALE 16+: NILF (P0430008)"
label variable ZPLF12    "MALE 16+: ARMY (P0430004)"
label variable ZPLF13    "FEM 16+ (P0430009)"
label variable ZPLF14    "FEM 16+: IN CIV LF (P0430012)"
label variable ZPLF15    "FEM 16+: IN CIV LF: EMP (P0430013)"
label variable ZPLF16    "FEM 16+: IN CIV LF: UNEMP (P0430014)"
label variable ZPLF17    "FEM 16+: NILF (P0430015)"
label variable ZPLF18    "FEM 16+: ARMY (P0430011)"
label variable ZPCL1     "EMP 16+: PRIV FOR PROFIT (CONSTRUCTED)"
label variable ZPCL2     "EMP 16+: PRIV NON PROFIT (CONSTRUCTED)"
label variable ZPCL3     "EMP 16+: LOCAL GOVT"
label variable ZPCL4     "EMP 16+: STATE GOVT"
label variable ZPCL5     "EMP 16+: FED GOVT"
label variable ZPCL6     "EMP 16+: SELF EMP"
label variable ZPCL7     "EMP 16+: UNPAID FAM WRKR"
label variable ZPED1     "AGE 25+ (P0370001)"
label variable ZPED2     "AGE 25+: LESS THAN HS (CONSTRUCTED)"
label variable ZPED3     "AGE 25+: HS GRAD (CONSTRUCTED)"
label variable ZPED4     "AGE 25+: SOME COLLEGE (CONSTRUCTED)"
label variable ZPED5     "AGE 25+: BA DEGREE (CONSTRUCTED)"
label variable ZPED6     "AGE 25+: MA+ DEGREE (CONSTRUCTED)"
label variable ZPED1W    "AGE 25+ WHITE (P148A001)"
label variable ZPED2W    "AGE 25+ WHITE: LESS THAN HS (CONSTRUCTED)"
label variable ZPED3W    "AGE 25+ WHITE: HS GRAD (CONSTRUCTED)"
label variable ZPED4W    "AGE 25+ WHITE: SOME COLLEGE (CONSTRUCTED)"
label variable ZPED5W    "AGE 25+ WHITE: BA DEGREE (CONSTRUCTED)"
label variable ZPED6W    "AGE 25+ WHITE: MA+ DEGREE (CONSTRUCTED)"
label variable ZPED1B    "AGE 25+ BLACK (P148B001)"
label variable ZPED2B    "AGE 25+ BLACK: LESS THAN HS (CONSTRUCTED)"
label variable ZPED3B    "AGE 25+ BLACK: HS GRAD (CONSTRUCTED)"
label variable ZPED4B    "AGE 25+ BLACK: SOME COLLEGE (CONSTRUCTED)"
label variable ZPED5B    "AGE 25+ BLACK: BA DEGREE (CONSTRUCTED)"
label variable ZPED6B    "AGE 25+ BLACK: MA+ DEGREE (CONSTRUCTED)"
label variable ZPED1I    "AGE 25+ AMIND (P148C001)"
label variable ZPED2I    "AGE 25+ AMIND: LESS THAN HS (CONSTRUCTED)"
label variable ZPED3I    "AGE 25+ AMIND: HS GRAD (CONSTRUCTED)"
label variable ZPED4I    "AGE 25+ AMIND: SOME COLLEGE (CONSTRUCTED)"
label variable ZPED5I    "AGE 25+ AMIND: BA DEGREE (CONSTRUCTED)"
label variable ZPED6I    "AGE 25+ AMIND: MA+ DEGREE (CONSTRUCTED)"
label variable ZPED1A    "AGE 25+ ASIAN (CONSTRUCTED) (CONSTRUCTED)"
label variable ZPED2A    "AGE 25+ ASIAN: LESS THAN HS (CONSTRUCTED)"
label variable ZPED3A    "AGE 25+ ASIAN: HS GRAD (CONSTRUCTED)"
label variable ZPED4A    "AGE 25+ ASIAN: SOME COLLEGE (CONSTRUCTED)"
label variable ZPED5A    "AGE 25+ ASIAN: BA DEGREE (CONSTRUCTED)"
label variable ZPED6A    "AGE 25+ ASIAN: MA+ DEGREE (CONSTRUCTED)"
label variable ZPED1O    "AGE 25+ OTHER (P148F001)"
label variable ZPED2O    "AGE 25+ OTHER: LESS THAN HS (CONSTRUCTED)"
label variable ZPED3O    "AGE 25+ OTHER: HS GRAD (CONSTRUCTED)"
label variable ZPED4O    "AGE 25+ OTHER: SOME COLLEGE (CONSTRUCTED)"
label variable ZPED5O    "AGE 25+ OTHER: BA DEGREE (CONSTRUCTED)"
label variable ZPED6O    "AGE 25+ OTHER: MA+ DEGREE (CONSTRUCTED)"
label variable ZPED1M    "AGE 25+ MULTI (P148G001)"
label variable ZPED2M    "AGE 25+ MULTI: LESS THAN HS (CONSTRUCTED)"
label variable ZPED3M    "AGE 25+ MULTI: HS GRAD (CONSTRUCTED)"
label variable ZPED4M    "AGE 25+ MULTI: SOME COLLEGE (CONSTRUCTED)"
label variable ZPED5M    "AGE 25+ MULTI: BA DEGREE (CONSTRUCTED)"
label variable ZPED6M    "AGE 25+ MULTI: MA+ DEGREE (CONSTRUCTED)"
label variable ZPED1H    "AGE 25+ HISP (P148H001)"
label variable ZPED2H    "AGE 25+ HISP: LESS THAN HS (CONSTRUCTED)"
label variable ZPED3H    "AGE 25+ HISP: HS GRAD (CONSTRUCTED)"
label variable ZPED4H    "AGE 25+ HISP: SOME COLLEGE (CONSTRUCTED)"
label variable ZPED5H    "AGE 25+ HISP: BA DEGREE (CONSTRUCTED)"
label variable ZPED6H    "AGE 25+ HISP: MA+ DEGREE (CONSTRUCTED)"
label variable ZPED1N    "AGE 25+ NH WHITE (P148I001)"
label variable ZPED2N    "AGE 25+ NH WHITE: LESS THAN HS (CONSTRUCTE"
label variable ZPED3N    "AGE 25+ NH WHITE: HS GRAD (CONSTRUCTED)"
label variable ZPED4N    "AGE 25+ NH WHITE: SOME COLLEGE (CONSTRUCTE"
label variable ZPED5N    "AGE 25+ NH WHITE: BA DEGREE (CONSTRUCTED)"
label variable ZPED6N    "AGE 25+ NH WHITE: MA+ DEGREE (CONSTRUCTED)"
label variable ZPHH      "HOUSHOLDS (P0100001)"
label variable ZPHT1     "FAMILY HH (P0100006)"
label variable ZPHT2     "FAM HH: MAR COUP OWN KIDS (P0100008)"
label variable ZPHT3     "FAM HH: MAR COUP NO KIDS (P0100009)"
label variable ZPHT4     "FAM HH: MALE HEAD OWN KIDS (P0100012)"
label variable ZPHT5     "FAM HH: MALE HEAD NO KIDS (P0100013)"
label variable ZPHT6     "FAM HH: FEM HEAD OWN KIDS (P0100015)"
label variable ZPHT7     "FAM HH: FEM HEAD NO KIDS (P0100016)"
label variable ZPHT8     "NON FAM HH: ALONE (P0100002)"
label variable ZPHT9     "NON FAM HH: WITH OTHERS (P0100017)"
label variable ZPHHW     "WHITE HOUSHOLDS (P146A001)"
label variable ZPHT1W    "WHITE FAMILY HH (CONSTRUCTED)"
label variable ZPHT2W    "WHITE FAM HH: MAR COUP OWN KIDS (CONSTRUCT"
label variable ZPHT3W    "WHITE FAM HH: MAR COUP NO KIDS (CONSTRUCTE"
label variable ZPHT4W    "WHITE FAM HH: MALE HEAD OWN KIDS (CONSTRUC"
label variable ZPHT5W    "WHITE FAM HH: MALE HEAD NO KIDS (CONSTRUCT"
label variable ZPHT6W    "WHITE FAM HH: FEM HEAD OWN KIDS (CONSTRUCT"
label variable ZPHT7W    "WHITE FAM HH: FEM HEAD NO KIDS (CONSTRUCTE"
label variable ZPHT8W    "WHITE NON FAM HH: ALONE (CONSTRUCTED)"
label variable ZPHT9W    "WHITE NON FAM HH: WITH OTHERS (CONSTRUCTED"
label variable ZPHHB     "BLACK HOUSHOLDS (P146B001)"
label variable ZPHT1B    "BLACK FAMILY HH (CONSTRUCTED)"
label variable ZPHT2B    "BLACK FAM HH: MAR COUP OWN KIDS (CONSTRUCT"
label variable ZPHT3B    "BLACK FAM HH: MAR COUP NO KIDS (CONSTRUCTE"
label variable ZPHT4B    "BLACK FAM HH: MALE HEAD OWN KIDS (CONSTRUC"
label variable ZPHT5B    "BLACK FAM HH: MALE HEAD NO KIDS (CONSTRUCT"
label variable ZPHT6B    "BLACK FAM HH: FEM HEAD OWN KIDS (CONSTRUCT"
label variable ZPHT7B    "BLACK FAM HH: FEM HEAD NO KIDS (CONSTRUCTE"
label variable ZPHT8B    "BLACK NON FAM HH: ALONE (CONSTRUCTED)"
label variable ZPHT9B    "BLACK NON FAM HH: WITH OTHERS (CONSTRUCTED"
label variable ZPHHI     "AMIND HOUSHOLDS (P146C001)"
label variable ZPHT1I    "AMIND FAMILY HH (CONSTRUCTED)"
label variable ZPHT2I    "AMIND FAM HH: MAR COUP OWN KIDS (CONSTRUCT"
label variable ZPHT3I    "AMIND FAM HH: MAR COUP NO KIDS (CONSTRUCTE"
label variable ZPHT4I    "AMIND FAM HH: MALE HEAD OWN KIDS (CONSTRUC"
label variable ZPHT5I    "AMIND FAM HH: MALE HEAD NO KIDS (CONSTRUCT"
label variable ZPHT6I    "AMIND FAM HH: FEM HEAD OWN KIDS (CONSTRUCT"
label variable ZPHT7I    "AMIND FAM HH: FEM HEAD NO KIDS (CONSTRUCTE"
label variable ZPHT8I    "AMIND NON FAM HH: ALONE (CONSTRUCTED)"
label variable ZPHT9I    "AMIND NON FAM HH: WITH OTHERS (CONSTRUCTED"
label variable ZPHHA     "ASIAN HOUSHOLDS (CONSTRUCTED)"
label variable ZPHT1A    "ASIAN FAMILY HH (CONSTRUCTED)"
label variable ZPHT2A    "ASIAN FAM HH: MAR COUP OWN KIDS (CONSTRUCT"
label variable ZPHT3A    "ASIAN FAM HH: MAR COUP NO KIDS (CONSTRUCTE"
label variable ZPHT4A    "ASIAN FAM HH: MALE HEAD OWN KIDS (CONSTRUC"
label variable ZPHT5A    "ASIAN FAM HH: MALE HEAD NO KIDS (CONSTRUCT"
label variable ZPHT6A    "ASIAN FAM HH: FEM HEAD OWN KIDS (CONSTRUCT"
label variable ZPHT7A    "ASIAN FAM HH: FEM HEAD NO KIDS (CONSTRUCTE"
label variable ZPHT8A    "ASIAN NON FAM HH: ALONE (CONSTRUCTED)"
label variable ZPHT9A    "ASIAN NON FAM HH: WITH OTHERS (CONSTRUCTED"
label variable ZPHHO     "OTHER HOUSHOLDS (P146F001)"
label variable ZPHT1O    "OTHER FAMILY HH (CONSTRUCTED)"
label variable ZPHT2O    "OTHER FAM HH: MAR COUP OWN KIDS (CONSTRUCT"
label variable ZPHT3O    "OTHER FAM HH: MAR COUP NO KIDS (CONSTRUCTE"
label variable ZPHT4O    "OTHER FAM HH: MALE HEAD OWN KIDS (CONSTRUC"
label variable ZPHT5O    "OTHER FAM HH: MALE HEAD NO KIDS (CONSTRUCT"
label variable ZPHT6O    "OTHER FAM HH: FEM HEAD OWN KIDS (CONSTRUCT"
label variable ZPHT7O    "OTHER FAM HH: FEM HEAD NO KIDS (CONSTRUCTE"
label variable ZPHT8O    "OTHER NON FAM HH: ALONE (CONSTRUCTED)"
label variable ZPHT9O    "OTHER NON FAM HH: WITH OTHERS (CONSTRUCTED"
label variable ZPHHM     "MULTI HOUSHOLDS (P146G001)"
label variable ZPHT1M    "MULTI FAMILY HH (CONSTRUCTED)"
label variable ZPHT2M    "MULTI FAM HH: MAR COUP OWN KIDS (CONSTRUCT"
label variable ZPHT3M    "MULTI FAM HH: MAR COUP NO KIDS (CONSTRUCTE"
label variable ZPHT4M    "MULTI FAM HH: MALE HEAD OWN KIDS (CONSTRUC"
label variable ZPHT5M    "MULTI FAM HH: MALE HEAD NO KIDS (CONSTRUCT"
label variable ZPHT6M    "MULTI FAM HH: FEM HEAD OWN KIDS (CONSTRUCT"
label variable ZPHT7M    "MULTI FAM HH: FEM HEAD NO KIDS (CONSTRUCTE"
label variable ZPHT8M    "MULTI NON FAM HH: ALONE (CONSTRUCTED)"
label variable ZPHT9M    "MULTI NON FAM HH: WITH MULTIS (CONSTRUCTED"
label variable ZPHHH     "HISP HOUSHOLDS (P146H001)"
label variable ZPHT1H    "HISP FAMILY HH (CONSTRUCTED)"
label variable ZPHT2H    "HISP FAM HH: MAR COUP OWN KIDS (CONSTRUCTE"
label variable ZPHT3H    "HISP FAM HH: MAR COUP NO KIDS (CONSTRUCTED"
label variable ZPHT4H    "HISP FAM HH: MALE HEAD OWN KIDS (CONSTRUCT"
label variable ZPHT5H    "HISP FAM HH: MALE HEAD NO KIDS (CONSTRUCTE"
label variable ZPHT6H    "HISP FAM HH: FEM HEAD OWN KIDS (CONSTRUCTE"
label variable ZPHT7H    "HISP FAM HH: FEM HEAD NO KIDS (CONSTRUCTED"
label variable ZPHT8H    "HISP NON FAM HH: ALONE (CONSTRUCTED)"
label variable ZPHT9H    "HISP NON FAM HH: WITH HISPS (CONSTRUCTED)"
label variable ZPHHN     "NH WHITE HOUSHOLDS (P146I001)"
label variable ZPHT1N    "NH WHITE FAMILY HH (CONSTRUCTED)"
label variable ZPHT2N    "NH WHITE FAM HH: MAR COUP OWN KIDS (CONSTR"
label variable ZPHT3N    "NH WHITE FAM HH: MAR COUP NO KIDS (CONSTRU"
label variable ZPHT4N    "NH WHITE FAM HH: MALE HEAD OWN KIDS (CONST"
label variable ZPHT5N    "NH WHITE FAM HH: MALE HEAD NO KIDS (CONSTR"
label variable ZPHT6N    "NH WHITE FAM HH: FEM HEAD OWN KIDS (CONSTR"
label variable ZPHT7N    "NH WHITE FAM HH: FEM HEAD NO KIDS (CONSTRU"
label variable ZPHT8N    "NH WHITE NON FAM HH: ALONE (CONSTRUCTED)"
label variable ZPHT9N    "NH WHITE NON FAM HH: WITH NH WHITES (CONST"
label variable ZPFP1     "FAMILIES   (P0900001)"
label variable ZPFP2     "FAMILIES WITH REL KIDS (CONSTRUCTED)"
label variable ZPFP3     "FAM WITH REL KIDS BELOW POV (CONSTRUCTED)"
label variable ZPFP1W    "WHITE FAMILIES   (P160A001))"
label variable ZPFP2W    "WHITE FAMILIES WITH REL KIDS (CONSTRUCTED)"
label variable ZPFP3W    "WHITE FAM WITH REL KIDS BELOW POV (CONSTRU"
label variable ZPFP1B    "BLACK FAMILIES  (P160B001)"
label variable ZPFP2B    "BLACK FAMILIES WITH REL KIDS (CONSTRUCTED)"
label variable ZPFP3B    "BLACK FAM WITH REL KIDS BELOW POV (CONSTRU"
label variable ZPFP1I    "AMINF FAMILIES (P160C001)"
label variable ZPFP2I    "AMIND FAMILIES WITH REL KIDS (CONSTRUCTED)"
label variable ZPFP3I    "AMIND FAM WITH REL KIDS BELOW POV (CONSTRU"
label variable ZPFP1A    "ASIAN FAMILIES  (CONSTRUCTED)"
label variable ZPFP2A    "ASIAN FAMILIES WITH REL KIDS (CONSTRUCTED)"
label variable ZPFP3A    "ASIAN FAM WITH REL KIDS BELOW POV (CONSTRU"
label variable ZPFP1O    "OTHER FAMILIES (P160F001)"
label variable ZPFP2O    "OTHER FAMILIES WITH REL KIDS (CONSTRUCTED)"
label variable ZPFP3O    "OTHER FAM WITH REL KIDS BELOW POV (CONSTRU"
label variable ZPFP1M    "MULTI FAMILIES (P160G001)"
label variable ZPFP2M    "MULTI FAMILIES WITH REL KIDS (CONSTRUCTED)"
label variable ZPFP3M    "MULTI FAM WITH REL KIDS BELOW POV (CONSTRU"
label variable ZPFP1H    "HISPANIC FAMILIES (P160H001)"
label variable ZPFP2H    "HISP FAMILIES WITH REL KIDS (CONSTRUCTED)"
label variable ZPFP3H    "HISP FAM WITH REL KIDS BELOW POV (CONSTRUC"
label variable ZPFP1N    "NH WHITE FAMILIES (P160I001)"
label variable ZPFP2N    "NH WHITE FAMILIES WITH REL KIDS (CONSTRUCT"
label variable ZPFP3N    "NH WHITE FAM WITH REL KIDS BELOW POV (CONS"
label variable ZHTP1     "POP IN HOUSING UNITS (H0150001)"
label variable ZHHU      "TOTAL HOUSING UNITS (H0010001)"
label variable ZHTN1     "OCCUPIED HU (H0070001)"
label variable ZHTN2     "OWN OCC HU (H0070002)"
label variable ZHTN3     "RENT OCC HU (H0070003)"
label variable ZHTB1     "TYPE BLDG: SINGLE FAM (CONSTRUCTED)"
label variable ZHTB2     "TYPE BLDG: 2-4 UNITS (CONSTRUCTED)"
label variable ZHTB3     "TYPE BLDG: 5-9 UNITS"
label variable ZHTB4     "TYPE BLDG: 10-19 UNITS"
label variable ZHTB5     "TYPE BLDG 20-49 UNITS"
label variable ZHTB6     "TYPE BLDG: 50+ UNITS"
label variable ZPPA1     "HH REC PUB ASSIST (P0640002)"
label variable Z_PRA1    "% WHITE"
label variable Z_PRA2    "% BLACK"
label variable Z_PRA3    "% AMIND"
label variable Z_PRA4    "% ASIAN"
label variable Z_PRA5    "% OTHER"
label variable Z_PRA6    "% MULTI"
label variable Z_PHR1    "% HISP"
label variable Z_PHR2    "% NH WHITE"
label variable Z_PHR3    "% NH BLACK"
label variable Z_PHR4    "% NH AMIND"
label variable Z_PHR5    "% NH ASIAN"
label variable Z_PHR6    "% NH OTHER"
label variable Z_PHR7    "% NH MULTI"
label variable Z_PHR8    "% HISP WHITE"
label variable Z_PHR9    "% HISP BLACK"
label variable Z_PHR10   "% HISP AMIND"
label variable Z_PHR11   "% HISP ASIAN"
label variable Z_PHR12   "% HISP OTHER"
label variable Z_PHR13   "% HISP MULTI"
label variable Z_POK2    "OWN KIDS 0-17: % IN MAR COUP FAM"
label variable Z_POK3    "OWN KIDS 0-17: % IN MALE HEAD FAM"
label variable Z_POK4    "OWN KIDS 0-17: % IN FEM HEAD FAM"
label variable Z_POK6    "OWN KIDS AGE 0-2: % IN MAR COUP HH"
label variable Z_POK7    "OWN KIDS AGE 0-2: % IN MALE HEAD HH"
label variable Z_POK8    "OWN KIDS AGE 0-2: % IN FEM HEAD HH"
label variable Z_POK10   "OWN KIDS AGE 3-5: % IN MAR COUP HH"
label variable Z_POK11   "OWN KIDS AGE 3-5: % IN MALE HEAD HH"
label variable Z_POK12   "OWN KIDS AGE 3-5: % IN FEM HEAD HH"
label variable Z_POK14   "OWN KIDS 6-11: % IN MAR COUP FAM"
label variable Z_POK15   "OWN KIDS 6-11: % IN MALE HEAD FAM"
label variable Z_POK16   "OWN KIDS 6-11: % IN FEM HEAD FAM"
label variable Z_POK18   "OWN KIDS 12-13: % IN MAR COUP FAM"
label variable Z_POK19   "OWN KIDS 12-13: % IN MALE HEAD FAM"
label variable Z_POK20   "OWN KIDS 12-13: % IN FEM HEAD FAM"
label variable Z_POK22   "OWN KIDS AGE 14: % IN MAR COUP FAM"
label variable Z_POK23   "OWN KIDS AGE 14: % IN MALE HEAD FAM"
label variable Z_POK24   "OWN KIDS AGE 14: % IN FEM HEAD FAM"
label variable Z_POK26   "OWN KIDS 15-17: % IN MAR COUP FAM"
label variable Z_POK27   "OWN KIDS 15-17: % IN MALE HEAD FAM"
label variable Z_POK28   "OWN KIDS 15-17: % IN FEM HEAD FAM"
label variable Z_PSX1    "% MALE"
label variable Z_PSX2    "% FEMALE"
label variable Z_PMS2    "% AGE 15+: SINGLE"
label variable Z_PMS3    "% AGE 15+: MARRIED"
label variable Z_PMS4    "% AGE 15+: SEPARATED"
label variable Z_PMS5    "% AGE 15+: WIDOWED"
label variable Z_PMS6    "% AGE 15+: DIVORCED"
label variable Z_PLI1    "% POP 5+ IN HH"
label variable Z_PLI2    "% POP 5+: LING ISOLATED"
label variable Z_PLI3    "% LING ISOLATED: AGE 5-17"
label variable Z_PLI4    "% LING ISOLATED: AGE 18-44"
label variable Z_PLI5    "% LING ISOLATED: AGE 45-64"
label variable Z_PLI6    "% LING ISOLATED: AGE 65 +"
label variable Z_PFB1    "% FOREIGN BORN"
label variable Z_PPV2    "% PERSONS BELOW POV"
label variable Z_PAG1    "% AGE 0-17"
label variable Z_PAG2    "% AGE 65 +"
label variable Z_PDO1    "% AGE 16-19"
label variable Z_PDO2    "% CIV 16-19"
label variable Z_PDO3    "% CIV 16-19: DROPOUT"
label variable Z_PDO1W   "% AGE 16-19: WHITE"
label variable Z_PDO2W   "% CIV 16-19: WHITE"
label variable Z_PDO3W   "% CIV 16-19: WHITE DROPOUT"
label variable Z_PDO1B   "% AGE 16-19: BLACK"
label variable Z_PDO2B   "% CIV 16-19: BLACK"
label variable Z_PDO3B   "% CIV 16-19: BLACK DROPOUT"
label variable Z_PDO1I   "% AGE 16-19: AMIND"
label variable Z_PDO2I   "% CIV 16-19: AMIND"
label variable Z_PDO3I   "% CIV 16-19: AMIND DROPOUT"
label variable Z_PDO1A   "% AGE 16-19: ASIAN"
label variable Z_PDO2A   "% CIV 16-19: ASIAN"
label variable Z_PDO3A   "% CIV 16-19: ASIAN DROPOUT"
label variable Z_PDO1O   "% AGE 16-19: OTHER"
label variable Z_PDO2O   "% CIV 16-19: OTHER"
label variable Z_PDO3O   "% CIV 16-19: OTHER DROPOUT"
label variable Z_PDO1M   "% AGE 16-19: MULTI"
label variable Z_PDO2M   "% CIV 16-19: MULTI"
label variable Z_PDO3M   "% CIV 16-19: MULTI DROPOUT"
label variable Z_PDO1H   "% AGE 16-19: HISP"
label variable Z_PDO2H   "% CIV 16-19: HISP"
label variable Z_PDO3H   "% CIV 16-19: HISP DROPOUT"
label variable Z_PDO1N   "% AGE 16-19: NH WHITE"
label variable Z_PDO2N   "% CIV 16-19: NH WHITE"
label variable Z_PDO3N   "% CIV 16-19: NH WHITE DROPOUT"
label variable Z_POC2    "% OCC 16+: MAN/BUS/FIN"
label variable Z_POC3    "% OCC 16+: PROF AND REL"
label variable Z_POC4    "% OCC 16+: SERVICE"
label variable Z_POC5    "% OCC 16+: SALES"
label variable Z_POC6    "% OCC 16+: OFFICE/ADM SUP"
label variable Z_POC7    "% OCC 16+: FOR/FARM/FISH"
label variable Z_POC8    "% OCC 16+: CONSTR/EXTR/MAINT"
label variable Z_POC9    "% OCC 16+: PROD/TRANS/MAT MOV"
label variable Z_PLF1    "% AGE 16+"
label variable Z_PLF2    "% AGE 16+: IN CIV LF"
label variable Z_PLF3    "% AGE 16+: IN CIV LF: EMP"
label variable Z_PLF4    "% AGE 16+: IN CIV LF: UNEMP"
label variable Z_PLF5    "% AGE 16+: NILF"
label variable Z_PLF6    "% AGE 16+: ARMY"
label variable Z_PLF7    "% MALE 16+"
label variable Z_PLF8    "% MALE 16+: IN CIV LF"
label variable Z_PLF9    "% MALE 16+: IN CIV LF: EMP"
label variable Z_PLF10   "% MALE 16+: IN CIV LF: UNEMP"
label variable Z_PLF11   "% MALE 16+: NILF"
label variable Z_PLF12   "% MALE 16+: ARMY"
label variable Z_PLF13   "% FEM 16+"
label variable Z_PLF14   "% FEM 16+: IN CIV LF"
label variable Z_PLF15   "% FEM 16+: IN CIV LF: EMP"
label variable Z_PLF16   "% FEM 16+: IN CIV LF: UNEMP"
label variable Z_PLF17   "% FEM 16+: NILF"
label variable Z_PLF18   "% FEM 16+: ARMY"
label variable Z_PCL1    "% EMP 16+: PRIV FOR PROFIT"
label variable Z_PCL2    "% EMP 16+: PRIV NON PROFIT"
label variable Z_PCL3    "% EMP 16+: LOCAL GOVT"
label variable Z_PCL4    "% EMP 16+: STATE GOVT"
label variable Z_PCL5    "% EMP 16+: FED GOVT"
label variable Z_PCL6    "% EMP 16+: SELF EMP"
label variable Z_PCL7    "% EMP 16+: UNPAID FAM WRKR"
label variable Z_PED1    "% AGE 25+"
label variable Z_PED2    "% AGE 25+: LESS THAN HS"
label variable Z_PED3    "% AGE 25+: HS GRAD"
label variable Z_PED4    "% AGE 25+: SOME COLLEGE"
label variable Z_PED5    "% AGE 25+: BA DEGREE"
label variable Z_PED6    "% AGE 25+: MA+ DEGREE"
label variable Z_PED1W   "% AGE 25+ WHITE"
label variable Z_PED2W   "% AGE 25+ WHITE: LESS THAN HS"
label variable Z_PED3W   "% AGE 25+ WHITE: HS GRAD"
label variable Z_PED4W   "% AGE 25+ WHITE: SOME COLLEGE"
label variable Z_PED5W   "% AGE 25+ WHITE: BA DEGREE"
label variable Z_PED6W   "% AGE 25+ WHITE: MA+ DEGREE"
label variable Z_PED1B   "% AGE 25+ BLACK"
label variable Z_PED2B   "% AGE 25+ BLACK: LESS THAN HS"
label variable Z_PED3B   "% AGE 25+ BLACK: HS GRAD"
label variable Z_PED4B   "% AGE 25+ BLACK: SOME COLLEGE"
label variable Z_PED5B   "% AGE 25+ BLACK: BA DEGREE"
label variable Z_PED6B   "% AGE 25+ BLACK: MA+ DEGREE"
label variable Z_PED1I   "% AGE 25+ AMIND"
label variable Z_PED2I   "% AGE 25+ AMIND: LESS THAN HS"
label variable Z_PED3I   "% AGE 25+ AMIND: HS GRAD"
label variable Z_PED4I   "% AGE 25+ AMIND: SOME COLLEGE"
label variable Z_PED5I   "% AGE 25+ AMIND: BA DEGREE"
label variable Z_PED6I   "% AGE 25+ AMIND: MA+ DEGREE"
label variable Z_PED1A   "% AGE 25+ ASIAN"
label variable Z_PED2A   "% AGE 25+ ASIAN: LESS THAN HS"
label variable Z_PED3A   "% AGE 25+ ASIAN: HS GRAD"
label variable Z_PED4A   "% AGE 25+ ASIAN: SOME COLLEGE"
label variable Z_PED5A   "% AGE 25+ ASIAN: BA DEGREE"
label variable Z_PED6A   "% AGE 25+ ASIAN: MA+ DEGREE"
label variable Z_PED1O   "% AGE 25+ OTHER"
label variable Z_PED2O   "% AGE 25+ OTHER: LESS THAN HS"
label variable Z_PED3O   "% AGE 25+ OTHER: HS GRAD"
label variable Z_PED4O   "% AGE 25+ OTHER: SOME COLLEGE"
label variable Z_PED5O   "% AGE 25+ OTHER: BA DEGREE"
label variable Z_PED6O   "% AGE 25+ OTHER: MA+ DEGREE"
label variable Z_PED1M   "% AGE 25+ MULTI"
label variable Z_PED2M   "% AGE 25+ MULTI: LESS THAN HS"
label variable Z_PED3M   "% AGE 25+ MULTI: HS GRAD"
label variable Z_PED4M   "% AGE 25+ MULTI: SOME COLLEGE"
label variable Z_PED5M   "% AGE 25+ MULTI: BA DEGREE"
label variable Z_PED6M   "% AGE 25+ MULTI: MA+ DEGREE"
label variable Z_PED1H   "% AGE 25+ HISP"
label variable Z_PED2H   "% AGE 25+ HISP: LESS THAN HS"
label variable Z_PED3H   "% AGE 25+ HISP: HS GRAD"
label variable Z_PED4H   "% AGE 25+ HISP: SOME COLLEGE"
label variable Z_PED5H   "% AGE 25+ HISP: BA DEGREE"
label variable Z_PED6H   "% AGE 25+ HISP: MA+ DEGREE"
label variable Z_PED1N   "% AGE 25+ NH WHITE"
label variable Z_PED2N   "% AGE 25+ NH WHITE: LESS THAN HS"
label variable Z_PED3N   "% AGE 25+ NH WHITE: HS GRAD"
label variable Z_PED4N   "% AGE 25+ NH WHITE: SOME COLLEGE"
label variable Z_PED5N   "% AGE 25+ NH WHITE: BA DEGREE"
label variable Z_PED6N   "% AGE 25+ NH WHITE: MA+ DEGREE"
label variable Z_PHT1    "% FAMILY HH"
label variable Z_PHT2    "% FAM HH: MAR COUP OWN KIDS"
label variable Z_PHT3    "% FAM HH: MAR COUP NO KIDS"
label variable Z_PHT4    "% FAM HH: MALE HEAD OWN KIDS"
label variable Z_PHT5    "% FAM HH: MALE HEAD NO KIDS"
label variable Z_PHT6    "% FAM HH: FEM HEAD OWN KIDS"
label variable Z_PHT7    "% FAM HH: FEM HEAD NO KIDS"
label variable Z_PHT8    "% NON FAM HH: ALONE"
label variable Z_PHT9    "% NON FAM HH: WITH OTHERS"
label variable Z_PHHW    "% WHITE HOUSHOLDS"
label variable Z_PHT1W   "% WHITE FAMILY HH"
label variable Z_PHT2W   "% WHITE FAM HH: MAR COUP OWN KIDS"
label variable Z_PHT3W   "% WHITE FAM HH: MAR COUP NO KIDS"
label variable Z_PHT4W   "% WHITE FAM HH: MALE HEAD OWN KIDS"
label variable Z_PHT5W   "% WHITE FAM HH: MALE HEAD NO KIDS"
label variable Z_PHT6W   "% WHITE FAM HH: FEM HEAD OWN KIDS"
label variable Z_PHT7W   "% WHITE FAM HH: FEM HEAD NO KIDS"
label variable Z_PHT8W   "% WHITE NON FAM HH: ALONE"
label variable Z_PHT9W   "% WHITE NON FAM HH: WITH OTHERS"
label variable Z_PHHB    "% BLACK HOUSHOLDS"
label variable Z_PHT1B   "% BLACK FAMILY HH"
label variable Z_PHT2B   "% BLACK FAM HH: MAR COUP OWN KIDS"
label variable Z_PHT3B   "% BLACK FAM HH: MAR COUP NO KIDS"
label variable Z_PHT4B   "% BLACK FAM HH: MALE HEAD OWN KIDS"
label variable Z_PHT5B   "% BLACK FAM HH: MALE HEAD NO KIDS"
label variable Z_PHT6B   "% BLACK FAM HH: FEM HEAD OWN KIDS"
label variable Z_PHT7B   "% BLACK FAM HH: FEM HEAD NO KIDS"
label variable Z_PHT8B   "% BLACK NON FAM HH: ALONE"
label variable Z_PHT9B   "% BLACK NON FAM HH: WITH OTHERS"
label variable Z_PHHI    "% AMIND HOUSHOLDS"
label variable Z_PHT1I   "% AMIND FAMILY HH"
label variable Z_PHT2I   "% AMIND FAM HH: MAR COUP OWN KIDS"
label variable Z_PHT3I   "% AMIND FAM HH: MAR COUP NO KIDS"
label variable Z_PHT4I   "% AMIND FAM HH: MALE HEAD OWN KIDS"
label variable Z_PHT5I   "% AMIND FAM HH: MALE HEAD NO KIDS"
label variable Z_PHT6I   "% AMIND FAM HH: FEM HEAD OWN KIDS"
label variable Z_PHT7I   "% AMIND FAM HH: FEM HEAD NO KIDS"
label variable Z_PHT8I   "% AMIND NON FAM HH: ALONE"
label variable Z_PHT9I   "% AMIND NON FAM HH: WITH OTHERS"
label variable Z_PHHA    "% ASIAN HOUSHOLDS"
label variable Z_PHT1A   "% ASIAN FAMILY HH"
label variable Z_PHT2A   "% ASIAN FAM HH: MAR COUP OWN KIDS"
label variable Z_PHT3A   "% ASIAN FAM HH: MAR COUP NO KIDS"
label variable Z_PHT4A   "% ASIAN FAM HH: MALE HEAD OWN KIDS"
label variable Z_PHT5A   "% ASIAN FAM HH: MALE HEAD NO KIDS"
label variable Z_PHT6A   "% ASIAN FAM HH: FEM HEAD OWN KIDS"
label variable Z_PHT7A   "% ASIAN FAM HH: FEM HEAD NO KIDS"
label variable Z_PHT8A   "% ASIAN NON FAM HH: ALONE"
label variable Z_PHT9A   "% ASIAN NON FAM HH: WITH OTHERS"
label variable Z_PHHO    "% OTHER HOUSHOLDS"
label variable Z_PHT1O   "% OTHER FAMILY HH"
label variable Z_PHT2O   "% OTHER FAM HH: MAR COUP OWN KIDS"
label variable Z_PHT3O   "% OTHER FAM HH: MAR COUP NO KIDS"
label variable Z_PHT4O   "% OTHER FAM HH: MALE HEAD OWN KIDS"
label variable Z_PHT5O   "% OTHER FAM HH: MALE HEAD NO KIDS"
label variable Z_PHT6O   "% OTHER FAM HH: FEM HEAD OWN KIDS"
label variable Z_PHT7O   "% OTHER FAM HH: FEM HEAD NO KIDS"
label variable Z_PHT8O   "% OTHER NON FAM HH: ALONE"
label variable Z_PHT9O   "% OTHER NON FAM HH: WITH OTHERS"
label variable Z_PHHM    "% MULTI HOUSHOLDS"
label variable Z_PHT1M   "% MULTI FAMILY HH"
label variable Z_PHT2M   "% MULTI FAM HH: MAR COUP OWN KIDS"
label variable Z_PHT3M   "% MULTI FAM HH: MAR COUP NO KIDS"
label variable Z_PHT4M   "% MULTI FAM HH: MALE HEAD OWN KIDS"
label variable Z_PHT5M   "% MULTI FAM HH: MALE HEAD NO KIDS"
label variable Z_PHT6M   "% MULTI FAM HH: FEM HEAD OWN KIDS"
label variable Z_PHT7M   "% MULTI FAM HH: FEM HEAD NO KIDS"
label variable Z_PHT8M   "% MULTI NON FAM HH: ALONE"
label variable Z_PHT9M   "% MULTI NON FAM HH: WITH OTHERS"
label variable Z_PHHH    "% HISP HOUSHOLDS"
label variable Z_PHT1H   "% HISP FAMILY HH"
label variable Z_PHT2H   "% HISP FAM HH: MAR COUP OWN KIDS"
label variable Z_PHT3H   "% HISP FAM HH: MAR COUP NO KIDS"
label variable Z_PHT4H   "% HISP FAM HH: MALE HEAD OWN KIDS"
label variable Z_PHT5H   "% HISP FAM HH: MALE HEAD NO KIDS"
label variable Z_PHT6H   "% HISP FAM HH: FEM HEAD OWN KIDS"
label variable Z_PHT7H   "% HISP FAM HH: FEM HEAD NO KIDS"
label variable Z_PHT8H   "% HISP NON FAM HH: ALONE"
label variable Z_PHT9H   "% HISP NON FAM HH: WITH OTHERS"
label variable Z_PHHN    "% NH WHITE HOUSHOLDS"
label variable Z_PHT1N   "% NH WHITE FAMILY HH"
label variable Z_PHT2N   "% NH WHITE FAM HH: MAR COUP OWN KIDS"
label variable Z_PHT3N   "% NH WHITE FAM HH: MAR COUP NO KIDS"
label variable Z_PHT4N   "% NH WHITE FAM HH: MALE HEAD OWN KIDS"
label variable Z_PHT5N   "% NH WHITE FAM HH: MALE HEAD NO KIDS"
label variable Z_PHT6N   "% NH WHITE FAM HH: FEM HEAD OWN KIDS"
label variable Z_PHT7N   "% NH WHITE FAM HH: FEM HEAD NO KIDS"
label variable Z_PHT8N   "% NH WHITE NON FAM HH: ALONE"
label variable Z_PHT9N   "% NH WHITE NON FAM HH: WITH OTHERS"
label variable Z_PFP1    "% FAMILY HOUSHOLDS"
label variable Z_PFP2    "% FAMILIES WITH REL KIDS"
label variable Z_PFP3    "% FAM WITH REL KIDS BELOW POV"
label variable Z_PFP1W   "% WHITE FAMILY HOUSHOLDS"
label variable Z_PFP2W   "% WHITE FAMILIES WITH REL KIDS"
label variable Z_PFP3W   "% WHITE FAM WITH REL KIDS BELOW POV"
label variable Z_PFP1B   "% BLACK FAMILY HOUSHOLDS"
label variable Z_PFP2B   "% BLACK FAMILIES WITH REL KIDS"
label variable Z_PFP3B   "% BLACK FAM WITH REL KIDS BELOW POV"
label variable Z_PFP1I   "% AMIND FAMILY HOUSHOLDS"
label variable Z_PFP2I   "% AMIND FAMILIES WITH REL KIDS"
label variable Z_PFP3I   "% AMIND FAM WITH REL KIDS BELOW POV"
label variable Z_PFP1A   "% ASIAN FAMILY HOUSHOLDS"
label variable Z_PFP2A   "% ASIAN FAMILIES WITH REL KIDS"
label variable Z_PFP3A   "% ASIAN FAM WITH REL KIDS BELOW POV"
label variable Z_PFP1O   "% OTHER FAMILY HOUSHOLDS"
label variable Z_PFP2O   "% OTHER FAMILIES WITH REL KIDS"
label variable Z_PFP3O   "% OTHER FAM WITH REL KIDS BELOW POV"
label variable Z_PFP1M   "% MULTI FAMILY HOUSHOLDS"
label variable Z_PFP2M   "% MULTI FAMILIES WITH REL KIDS"
label variable Z_PFP3M   "% MULTI FAM WITH REL KIDS BELOW POV"
label variable Z_PFP1H   "% HISP FAMILY HOUSHOLDS"
label variable Z_PFP2H   "% HISP FAMILIES WITH REL KIDS"
label variable Z_PFP3H   "% HISP FAM WITH REL KIDS BELOW POV"
label variable Z_PFP1N   "% NH WHITE FAMILY HOUSHOLDS"
label variable Z_PFP2N   "% NH WHITE FAMILIES WITH REL KIDS"
label variable Z_PFP3N   "% NH WHITE FAM WITH REL KIDS BELOW POV"
label variable Z_PPA1    "% HH REC PUB ASSIST"
label variable Z_HTP1    "% POP IN HOUSING UNTIS"
label variable Z_HTN1    "% OCCUPIED HU"
label variable Z_HTN2    "% OWN OCC HU"
label variable Z_HTN3    "% RENT OCC HU"
label variable Z_HTB1    "% TYPE BLDG: SINGLE FAM"
label variable Z_HTB2    "% TYPE BLDG: 2-4 UNITS"
label variable Z_HTB3    "% TYPE BLDG: 5-9 UNITS"
label variable Z_HTB4    "% TYPE BLDG: 10-19 UNITS"
label variable Z_HTB5    "% TYPE BLDG 20-49 UNITS"
label variable Z_HTB6    "% TYPE BLDG: 50+ UNITS"

save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Restricted\Geocode\zctas.dta", replace
