/***************************
TOTAL PER PUPIL EXPENDITURES 
***************************/

/*
P2-4-5-6-7HOWPAY
*/

replace P2HOWPAY = .a if P2HOWPAY == -1 // NOT APPLICABLE
replace P2HOWPAY = .b if P2HOWPAY == -9 // NOT ASCERTAINED
replace P2HOWPAY = .c if P2HOWPAY == -7 // REFUSED
replace P2HOWPAY = .d if P2HOWPAY == -8 // DON'T KNOW

replace P4HOWPAY = .a if P4HOWPAY == -1 // NOT APPLICABLE
replace P4HOWPAY = .b if P4HOWPAY == -9 // NOT ASCERTAINED
replace P4HOWPAY = .c if P4HOWPAY == -7 // REFUSED
replace P4HOWPAY = .d if P4HOWPAY == -8 // DON'T KNOW

replace P5HOWPAY = .a if P5HOWPAY == -1 // NOT APPLICABLE
replace P5HOWPAY = .b if P5HOWPAY == -9 // NOT ASCERTAINED
replace P5HOWPAY = .c if P5HOWPAY == -7 // REFUSED
replace P5HOWPAY = .d if P5HOWPAY == -8 // DON'T KNOW

replace P6HOWPAY = .a if P6HOWPAY == -1 // NOT APPLICABLE
replace P6HOWPAY = .b if P6HOWPAY == -9 // NOT ASCERTAINED
replace P6HOWPAY = .c if P6HOWPAY == -7 // REFUSED
replace P6HOWPAY = .d if P6HOWPAY == -8 // DON'T KNOW

replace P7HOWPAY = .a if P7HOWPAY == -1 // NOT APPLICABLE
replace P7HOWPAY = .b if P7HOWPAY == -9 // NOT ASCERTAINED
replace P7HOWPAY = .c if P7HOWPAY == -7 // REFUSED
replace P7HOWPAY = .d if P7HOWPAY == -8 // DON'T KNOW
