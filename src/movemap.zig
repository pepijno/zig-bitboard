const ChessLookup = @import("chesslookup.zig");

fn getSliderHCond(slider_square: u64, occupy: u64) u64 {
    var result: u64 = 0;
    switch (slider_square) {
        0 => {
            result = 2;
            if ((occupy & 2) == 0) result |= 4;
            if ((occupy & 6) == 0) result |= 8;
            if ((occupy & 14) == 0) result |= 16;
            if ((occupy & 30) == 0) result |= 32;
            if ((occupy & 62) == 0) result |= 64;
            if ((occupy & 126) == 0) result |= 128;
            return result;
        },
        1 => {
            result = 5;
            if ((occupy & 4) == 0) result |= 8;
            if ((occupy & 12) == 0) result |= 16;
            if ((occupy & 28) == 0) result |= 32;
            if ((occupy & 60) == 0) result |= 64;
            if ((occupy & 124) == 0) result |= 128;
            return result;
        },
        2 => {
            result = 10;
            if ((occupy & 2) == 0) result |= 1;
            if ((occupy & 8) == 0) result |= 16;
            if ((occupy & 24) == 0) result |= 32;
            if ((occupy & 56) == 0) result |= 64;
            if ((occupy & 120) == 0) result |= 128;
            return result;
        },
        3 => {
            result = 20;
            if ((occupy & 4) == 0) result |= 2;
            if ((occupy & 6) == 0) result |= 1;
            if ((occupy & 16) == 0) result |= 32;
            if ((occupy & 48) == 0) result |= 64;
            if ((occupy & 112) == 0) result |= 128;
            return result;
        },
        4 => {
            result = 40;
            if ((occupy & 8) == 0) result |= 4;
            if ((occupy & 12) == 0) result |= 2;
            if ((occupy & 14) == 0) result |= 1;
            if ((occupy & 32) == 0) result |= 64;
            if ((occupy & 96) == 0) result |= 128;
            return result;
        },
        5 => {
            result = 80;
            if ((occupy & 16) == 0) result |= 8;
            if ((occupy & 24) == 0) result |= 4;
            if ((occupy & 28) == 0) result |= 2;
            if ((occupy & 30) == 0) result |= 1;
            if ((occupy & 64) == 0) result |= 128;
            return result;
        },
        6 => {
            result = 160;
            if ((occupy & 32) == 0) result |= 16;
            if ((occupy & 48) == 0) result |= 8;
            if ((occupy & 56) == 0) result |= 4;
            if ((occupy & 60) == 0) result |= 2;
            if ((occupy & 62) == 0) result |= 1;
            return result;
        },
        7 => {
            result = 64;
            if ((occupy & 64) == 0) result |= 32;
            if ((occupy & 96) == 0) result |= 16;
            if ((occupy & 112) == 0) result |= 8;
            if ((occupy & 120) == 0) result |= 4;
            if ((occupy & 124) == 0) result |= 2;
            if ((occupy & 126) == 0) result |= 1;
            return result;
        },
        8 => {
            result = 512;
            if ((occupy & 512) == 0) result |= 1024;
            if ((occupy & 1536) == 0) result |= 2048;
            if ((occupy & 3584) == 0) result |= 4096;
            if ((occupy & 7680) == 0) result |= 8192;
            if ((occupy & 15872) == 0) result |= 16384;
            if ((occupy & 32256) == 0) result |= 32768;
            return result;
        },
        9 => {
            result = 1280;
            if ((occupy & 1024) == 0) result |= 2048;
            if ((occupy & 3072) == 0) result |= 4096;
            if ((occupy & 7168) == 0) result |= 8192;
            if ((occupy & 15360) == 0) result |= 16384;
            if ((occupy & 31744) == 0) result |= 32768;
            return result;
        },
        10 => {
            result = 2560;
            if ((occupy & 512) == 0) result |= 256;
            if ((occupy & 2048) == 0) result |= 4096;
            if ((occupy & 6144) == 0) result |= 8192;
            if ((occupy & 14336) == 0) result |= 16384;
            if ((occupy & 30720) == 0) result |= 32768;
            return result;
        },
        11 => {
            result = 5120;
            if ((occupy & 1024) == 0) result |= 512;
            if ((occupy & 1536) == 0) result |= 256;
            if ((occupy & 4096) == 0) result |= 8192;
            if ((occupy & 12288) == 0) result |= 16384;
            if ((occupy & 28672) == 0) result |= 32768;
            return result;
        },
        12 => {
            result = 10240;
            if ((occupy & 2048) == 0) result |= 1024;
            if ((occupy & 3072) == 0) result |= 512;
            if ((occupy & 3584) == 0) result |= 256;
            if ((occupy & 8192) == 0) result |= 16384;
            if ((occupy & 24576) == 0) result |= 32768;
            return result;
        },
        13 => {
            result = 20480;
            if ((occupy & 4096) == 0) result |= 2048;
            if ((occupy & 6144) == 0) result |= 1024;
            if ((occupy & 7168) == 0) result |= 512;
            if ((occupy & 7680) == 0) result |= 256;
            if ((occupy & 16384) == 0) result |= 32768;
            return result;
        },
        14 => {
            result = 40960;
            if ((occupy & 8192) == 0) result |= 4096;
            if ((occupy & 12288) == 0) result |= 2048;
            if ((occupy & 14336) == 0) result |= 1024;
            if ((occupy & 15360) == 0) result |= 512;
            if ((occupy & 15872) == 0) result |= 256;
            return result;
        },
        15 => {
            result = 16384;
            if ((occupy & 16384) == 0) result |= 8192;
            if ((occupy & 24576) == 0) result |= 4096;
            if ((occupy & 28672) == 0) result |= 2048;
            if ((occupy & 30720) == 0) result |= 1024;
            if ((occupy & 31744) == 0) result |= 512;
            if ((occupy & 32256) == 0) result |= 256;
            return result;
        },
        16 => {
            result = 131072;
            if ((occupy & 131072) == 0) result |= 262144;
            if ((occupy & 393216) == 0) result |= 524288;
            if ((occupy & 917504) == 0) result |= 1048576;
            if ((occupy & 1966080) == 0) result |= 2097152;
            if ((occupy & 4063232) == 0) result |= 4194304;
            if ((occupy & 8257536) == 0) result |= 8388608;
            return result;
        },
        17 => {
            result = 327680;
            if ((occupy & 262144) == 0) result |= 524288;
            if ((occupy & 786432) == 0) result |= 1048576;
            if ((occupy & 1835008) == 0) result |= 2097152;
            if ((occupy & 3932160) == 0) result |= 4194304;
            if ((occupy & 8126464) == 0) result |= 8388608;
            return result;
        },
        18 => {
            result = 655360;
            if ((occupy & 131072) == 0) result |= 65536;
            if ((occupy & 524288) == 0) result |= 1048576;
            if ((occupy & 1572864) == 0) result |= 2097152;
            if ((occupy & 3670016) == 0) result |= 4194304;
            if ((occupy & 7864320) == 0) result |= 8388608;
            return result;
        },
        19 => {
            result = 1310720;
            if ((occupy & 262144) == 0) result |= 131072;
            if ((occupy & 393216) == 0) result |= 65536;
            if ((occupy & 1048576) == 0) result |= 2097152;
            if ((occupy & 3145728) == 0) result |= 4194304;
            if ((occupy & 7340032) == 0) result |= 8388608;
            return result;
        },
        20 => {
            result = 2621440;
            if ((occupy & 524288) == 0) result |= 262144;
            if ((occupy & 786432) == 0) result |= 131072;
            if ((occupy & 917504) == 0) result |= 65536;
            if ((occupy & 2097152) == 0) result |= 4194304;
            if ((occupy & 6291456) == 0) result |= 8388608;
            return result;
        },
        21 => {
            result = 5242880;
            if ((occupy & 1048576) == 0) result |= 524288;
            if ((occupy & 1572864) == 0) result |= 262144;
            if ((occupy & 1835008) == 0) result |= 131072;
            if ((occupy & 1966080) == 0) result |= 65536;
            if ((occupy & 4194304) == 0) result |= 8388608;
            return result;
        },
        22 => {
            result = 10485760;
            if ((occupy & 2097152) == 0) result |= 1048576;
            if ((occupy & 3145728) == 0) result |= 524288;
            if ((occupy & 3670016) == 0) result |= 262144;
            if ((occupy & 3932160) == 0) result |= 131072;
            if ((occupy & 4063232) == 0) result |= 65536;
            return result;
        },
        23 => {
            result = 4194304;
            if ((occupy & 4194304) == 0) result |= 2097152;
            if ((occupy & 6291456) == 0) result |= 1048576;
            if ((occupy & 7340032) == 0) result |= 524288;
            if ((occupy & 7864320) == 0) result |= 262144;
            if ((occupy & 8126464) == 0) result |= 131072;
            if ((occupy & 8257536) == 0) result |= 65536;
            return result;
        },
        24 => {
            result = 33554432;
            if ((occupy & 33554432) == 0) result |= 67108864;
            if ((occupy & 100663296) == 0) result |= 134217728;
            if ((occupy & 234881024) == 0) result |= 268435456;
            if ((occupy & 503316480) == 0) result |= 536870912;
            if ((occupy & 1040187392) == 0) result |= 1073741824;
            if ((occupy & 2113929216) == 0) result |= 2147483648;
            return result;
        },
        25 => {
            result = 83886080;
            if ((occupy & 67108864) == 0) result |= 134217728;
            if ((occupy & 201326592) == 0) result |= 268435456;
            if ((occupy & 469762048) == 0) result |= 536870912;
            if ((occupy & 1006632960) == 0) result |= 1073741824;
            if ((occupy & 2080374784) == 0) result |= 2147483648;
            return result;
        },
        26 => {
            result = 167772160;
            if ((occupy & 33554432) == 0) result |= 16777216;
            if ((occupy & 134217728) == 0) result |= 268435456;
            if ((occupy & 402653184) == 0) result |= 536870912;
            if ((occupy & 939524096) == 0) result |= 1073741824;
            if ((occupy & 2013265920) == 0) result |= 2147483648;
            return result;
        },
        27 => {
            result = 335544320;
            if ((occupy & 67108864) == 0) result |= 33554432;
            if ((occupy & 100663296) == 0) result |= 16777216;
            if ((occupy & 268435456) == 0) result |= 536870912;
            if ((occupy & 805306368) == 0) result |= 1073741824;
            if ((occupy & 1879048192) == 0) result |= 2147483648;
            return result;
        },
        28 => {
            result = 671088640;
            if ((occupy & 134217728) == 0) result |= 67108864;
            if ((occupy & 201326592) == 0) result |= 33554432;
            if ((occupy & 234881024) == 0) result |= 16777216;
            if ((occupy & 536870912) == 0) result |= 1073741824;
            if ((occupy & 1610612736) == 0) result |= 2147483648;
            return result;
        },
        29 => {
            result = 1342177280;
            if ((occupy & 268435456) == 0) result |= 134217728;
            if ((occupy & 402653184) == 0) result |= 67108864;
            if ((occupy & 469762048) == 0) result |= 33554432;
            if ((occupy & 503316480) == 0) result |= 16777216;
            if ((occupy & 1073741824) == 0) result |= 2147483648;
            return result;
        },
        30 => {
            result = 2684354560;
            if ((occupy & 536870912) == 0) result |= 268435456;
            if ((occupy & 805306368) == 0) result |= 134217728;
            if ((occupy & 939524096) == 0) result |= 67108864;
            if ((occupy & 1006632960) == 0) result |= 33554432;
            if ((occupy & 1040187392) == 0) result |= 16777216;
            return result;
        },
        31 => {
            result = 1073741824;
            if ((occupy & 1073741824) == 0) result |= 536870912;
            if ((occupy & 1610612736) == 0) result |= 268435456;
            if ((occupy & 1879048192) == 0) result |= 134217728;
            if ((occupy & 2013265920) == 0) result |= 67108864;
            if ((occupy & 2080374784) == 0) result |= 33554432;
            if ((occupy & 2113929216) == 0) result |= 16777216;
            return result;
        },
        32 => {
            result = 8589934592;
            if ((occupy & 8589934592) == 0) result |= 17179869184;
            if ((occupy & 25769803776) == 0) result |= 34359738368;
            if ((occupy & 60129542144) == 0) result |= 68719476736;
            if ((occupy & 128849018880) == 0) result |= 137438953472;
            if ((occupy & 266287972352) == 0) result |= 274877906944;
            if ((occupy & 541165879296) == 0) result |= 549755813888;
            return result;
        },
        33 => {
            result = 21474836480;
            if ((occupy & 17179869184) == 0) result |= 34359738368;
            if ((occupy & 51539607552) == 0) result |= 68719476736;
            if ((occupy & 120259084288) == 0) result |= 137438953472;
            if ((occupy & 257698037760) == 0) result |= 274877906944;
            if ((occupy & 532575944704) == 0) result |= 549755813888;
            return result;
        },
        34 => {
            result = 42949672960;
            if ((occupy & 8589934592) == 0) result |= 4294967296;
            if ((occupy & 34359738368) == 0) result |= 68719476736;
            if ((occupy & 103079215104) == 0) result |= 137438953472;
            if ((occupy & 240518168576) == 0) result |= 274877906944;
            if ((occupy & 515396075520) == 0) result |= 549755813888;
            return result;
        },
        35 => {
            result = 85899345920;
            if ((occupy & 17179869184) == 0) result |= 8589934592;
            if ((occupy & 25769803776) == 0) result |= 4294967296;
            if ((occupy & 68719476736) == 0) result |= 137438953472;
            if ((occupy & 206158430208) == 0) result |= 274877906944;
            if ((occupy & 481036337152) == 0) result |= 549755813888;
            return result;
        },
        36 => {
            result = 171798691840;
            if ((occupy & 34359738368) == 0) result |= 17179869184;
            if ((occupy & 51539607552) == 0) result |= 8589934592;
            if ((occupy & 60129542144) == 0) result |= 4294967296;
            if ((occupy & 137438953472) == 0) result |= 274877906944;
            if ((occupy & 412316860416) == 0) result |= 549755813888;
            return result;
        },
        37 => {
            result = 343597383680;
            if ((occupy & 68719476736) == 0) result |= 34359738368;
            if ((occupy & 103079215104) == 0) result |= 17179869184;
            if ((occupy & 120259084288) == 0) result |= 8589934592;
            if ((occupy & 128849018880) == 0) result |= 4294967296;
            if ((occupy & 274877906944) == 0) result |= 549755813888;
            return result;
        },
        38 => {
            result = 687194767360;
            if ((occupy & 137438953472) == 0) result |= 68719476736;
            if ((occupy & 206158430208) == 0) result |= 34359738368;
            if ((occupy & 240518168576) == 0) result |= 17179869184;
            if ((occupy & 257698037760) == 0) result |= 8589934592;
            if ((occupy & 266287972352) == 0) result |= 4294967296;
            return result;
        },
        39 => {
            result = 274877906944;
            if ((occupy & 274877906944) == 0) result |= 137438953472;
            if ((occupy & 412316860416) == 0) result |= 68719476736;
            if ((occupy & 481036337152) == 0) result |= 34359738368;
            if ((occupy & 515396075520) == 0) result |= 17179869184;
            if ((occupy & 532575944704) == 0) result |= 8589934592;
            if ((occupy & 541165879296) == 0) result |= 4294967296;
            return result;
        },
        40 => {
            result = 2199023255552;
            if ((occupy & 2199023255552) == 0) result |= 4398046511104;
            if ((occupy & 6597069766656) == 0) result |= 8796093022208;
            if ((occupy & 15393162788864) == 0) result |= 17592186044416;
            if ((occupy & 32985348833280) == 0) result |= 35184372088832;
            if ((occupy & 68169720922112) == 0) result |= 70368744177664;
            if ((occupy & 138538465099776) == 0) result |= 140737488355328;
            return result;
        },
        41 => {
            result = 5497558138880;
            if ((occupy & 4398046511104) == 0) result |= 8796093022208;
            if ((occupy & 13194139533312) == 0) result |= 17592186044416;
            if ((occupy & 30786325577728) == 0) result |= 35184372088832;
            if ((occupy & 65970697666560) == 0) result |= 70368744177664;
            if ((occupy & 136339441844224) == 0) result |= 140737488355328;
            return result;
        },
        42 => {
            result = 10995116277760;
            if ((occupy & 2199023255552) == 0) result |= 1099511627776;
            if ((occupy & 8796093022208) == 0) result |= 17592186044416;
            if ((occupy & 26388279066624) == 0) result |= 35184372088832;
            if ((occupy & 61572651155456) == 0) result |= 70368744177664;
            if ((occupy & 131941395333120) == 0) result |= 140737488355328;
            return result;
        },
        43 => {
            result = 21990232555520;
            if ((occupy & 4398046511104) == 0) result |= 2199023255552;
            if ((occupy & 6597069766656) == 0) result |= 1099511627776;
            if ((occupy & 17592186044416) == 0) result |= 35184372088832;
            if ((occupy & 52776558133248) == 0) result |= 70368744177664;
            if ((occupy & 123145302310912) == 0) result |= 140737488355328;
            return result;
        },
        44 => {
            result = 43980465111040;
            if ((occupy & 8796093022208) == 0) result |= 4398046511104;
            if ((occupy & 13194139533312) == 0) result |= 2199023255552;
            if ((occupy & 15393162788864) == 0) result |= 1099511627776;
            if ((occupy & 35184372088832) == 0) result |= 70368744177664;
            if ((occupy & 105553116266496) == 0) result |= 140737488355328;
            return result;
        },
        45 => {
            result = 87960930222080;
            if ((occupy & 17592186044416) == 0) result |= 8796093022208;
            if ((occupy & 26388279066624) == 0) result |= 4398046511104;
            if ((occupy & 30786325577728) == 0) result |= 2199023255552;
            if ((occupy & 32985348833280) == 0) result |= 1099511627776;
            if ((occupy & 70368744177664) == 0) result |= 140737488355328;
            return result;
        },
        46 => {
            result = 175921860444160;
            if ((occupy & 35184372088832) == 0) result |= 17592186044416;
            if ((occupy & 52776558133248) == 0) result |= 8796093022208;
            if ((occupy & 61572651155456) == 0) result |= 4398046511104;
            if ((occupy & 65970697666560) == 0) result |= 2199023255552;
            if ((occupy & 68169720922112) == 0) result |= 1099511627776;
            return result;
        },
        47 => {
            result = 70368744177664;
            if ((occupy & 70368744177664) == 0) result |= 35184372088832;
            if ((occupy & 105553116266496) == 0) result |= 17592186044416;
            if ((occupy & 123145302310912) == 0) result |= 8796093022208;
            if ((occupy & 131941395333120) == 0) result |= 4398046511104;
            if ((occupy & 136339441844224) == 0) result |= 2199023255552;
            if ((occupy & 138538465099776) == 0) result |= 1099511627776;
            return result;
        },
        48 => {
            result = 562949953421312;
            if ((occupy & 562949953421312) == 0) result |= 1125899906842624;
            if ((occupy & 1688849860263936) == 0) result |= 2251799813685248;
            if ((occupy & 3940649673949184) == 0) result |= 4503599627370496;
            if ((occupy & 8444249301319680) == 0) result |= 9007199254740992;
            if ((occupy & 17451448556060672) == 0) result |= 18014398509481984;
            if ((occupy & 35465847065542656) == 0) result |= 36028797018963968;
            return result;
        },
        49 => {
            result = 1407374883553280;
            if ((occupy & 1125899906842624) == 0) result |= 2251799813685248;
            if ((occupy & 3377699720527872) == 0) result |= 4503599627370496;
            if ((occupy & 7881299347898368) == 0) result |= 9007199254740992;
            if ((occupy & 16888498602639360) == 0) result |= 18014398509481984;
            if ((occupy & 34902897112121344) == 0) result |= 36028797018963968;
            return result;
        },
        50 => {
            result = 2814749767106560;
            if ((occupy & 562949953421312) == 0) result |= 281474976710656;
            if ((occupy & 2251799813685248) == 0) result |= 4503599627370496;
            if ((occupy & 6755399441055744) == 0) result |= 9007199254740992;
            if ((occupy & 15762598695796736) == 0) result |= 18014398509481984;
            if ((occupy & 33776997205278720) == 0) result |= 36028797018963968;
            return result;
        },
        51 => {
            result = 5629499534213120;
            if ((occupy & 1125899906842624) == 0) result |= 562949953421312;
            if ((occupy & 1688849860263936) == 0) result |= 281474976710656;
            if ((occupy & 4503599627370496) == 0) result |= 9007199254740992;
            if ((occupy & 13510798882111488) == 0) result |= 18014398509481984;
            if ((occupy & 31525197391593472) == 0) result |= 36028797018963968;
            return result;
        },
        52 => {
            result = 11258999068426240;
            if ((occupy & 2251799813685248) == 0) result |= 1125899906842624;
            if ((occupy & 3377699720527872) == 0) result |= 562949953421312;
            if ((occupy & 3940649673949184) == 0) result |= 281474976710656;
            if ((occupy & 9007199254740992) == 0) result |= 18014398509481984;
            if ((occupy & 27021597764222976) == 0) result |= 36028797018963968;
            return result;
        },
        53 => {
            result = 22517998136852480;
            if ((occupy & 4503599627370496) == 0) result |= 2251799813685248;
            if ((occupy & 6755399441055744) == 0) result |= 1125899906842624;
            if ((occupy & 7881299347898368) == 0) result |= 562949953421312;
            if ((occupy & 8444249301319680) == 0) result |= 281474976710656;
            if ((occupy & 18014398509481984) == 0) result |= 36028797018963968;
            return result;
        },
        54 => {
            result = 45035996273704960;
            if ((occupy & 9007199254740992) == 0) result |= 4503599627370496;
            if ((occupy & 13510798882111488) == 0) result |= 2251799813685248;
            if ((occupy & 15762598695796736) == 0) result |= 1125899906842624;
            if ((occupy & 16888498602639360) == 0) result |= 562949953421312;
            if ((occupy & 17451448556060672) == 0) result |= 281474976710656;
            return result;
        },
        55 => {
            result = 18014398509481984;
            if ((occupy & 18014398509481984) == 0) result |= 9007199254740992;
            if ((occupy & 27021597764222976) == 0) result |= 4503599627370496;
            if ((occupy & 31525197391593472) == 0) result |= 2251799813685248;
            if ((occupy & 33776997205278720) == 0) result |= 1125899906842624;
            if ((occupy & 34902897112121344) == 0) result |= 562949953421312;
            if ((occupy & 35465847065542656) == 0) result |= 281474976710656;
            return result;
        },
        56 => {
            result = 144115188075855872;
            if ((occupy & 144115188075855872) == 0) result |= 288230376151711744;
            if ((occupy & 432345564227567616) == 0) result |= 576460752303423488;
            if ((occupy & 1008806316530991104) == 0) result |= 1152921504606846976;
            if ((occupy & 2161727821137838080) == 0) result |= 2305843009213693952;
            if ((occupy & 4467570830351532032) == 0) result |= 4611686018427387904;
            if ((occupy & 9079256848778919936) == 0) result |= 9223372036854775808;
            return result;
        },
        57 => {
            result = 360287970189639680;
            if ((occupy & 288230376151711744) == 0) result |= 576460752303423488;
            if ((occupy & 864691128455135232) == 0) result |= 1152921504606846976;
            if ((occupy & 2017612633061982208) == 0) result |= 2305843009213693952;
            if ((occupy & 4323455642275676160) == 0) result |= 4611686018427387904;
            if ((occupy & 8935141660703064064) == 0) result |= 9223372036854775808;
            return result;
        },
        58 => {
            result = 720575940379279360;
            if ((occupy & 144115188075855872) == 0) result |= 72057594037927936;
            if ((occupy & 576460752303423488) == 0) result |= 1152921504606846976;
            if ((occupy & 1729382256910270464) == 0) result |= 2305843009213693952;
            if ((occupy & 4035225266123964416) == 0) result |= 4611686018427387904;
            if ((occupy & 8646911284551352320) == 0) result |= 9223372036854775808;
            return result;
        },
        59 => {
            result = 1441151880758558720;
            if ((occupy & 288230376151711744) == 0) result |= 144115188075855872;
            if ((occupy & 432345564227567616) == 0) result |= 72057594037927936;
            if ((occupy & 1152921504606846976) == 0) result |= 2305843009213693952;
            if ((occupy & 3458764513820540928) == 0) result |= 4611686018427387904;
            if ((occupy & 8070450532247928832) == 0) result |= 9223372036854775808;
            return result;
        },
        60 => {
            result = 2882303761517117440;
            if ((occupy & 576460752303423488) == 0) result |= 288230376151711744;
            if ((occupy & 864691128455135232) == 0) result |= 144115188075855872;
            if ((occupy & 1008806316530991104) == 0) result |= 72057594037927936;
            if ((occupy & 2305843009213693952) == 0) result |= 4611686018427387904;
            if ((occupy & 6917529027641081856) == 0) result |= 9223372036854775808;
            return result;
        },
        61 => {
            result = 5764607523034234880;
            if ((occupy & 1152921504606846976) == 0) result |= 576460752303423488;
            if ((occupy & 1729382256910270464) == 0) result |= 288230376151711744;
            if ((occupy & 2017612633061982208) == 0) result |= 144115188075855872;
            if ((occupy & 2161727821137838080) == 0) result |= 72057594037927936;
            if ((occupy & 4611686018427387904) == 0) result |= 9223372036854775808;
            return result;
        },
        62 => {
            result = 11529215046068469760;
            if ((occupy & 2305843009213693952) == 0) result |= 1152921504606846976;
            if ((occupy & 3458764513820540928) == 0) result |= 576460752303423488;
            if ((occupy & 4035225266123964416) == 0) result |= 288230376151711744;
            if ((occupy & 4323455642275676160) == 0) result |= 144115188075855872;
            if ((occupy & 4467570830351532032) == 0) result |= 72057594037927936;
            return result;
        },
        63 => {
            result = 4611686018427387904;
            if ((occupy & 4611686018427387904) == 0) result |= 2305843009213693952;
            if ((occupy & 6917529027641081856) == 0) result |= 1152921504606846976;
            if ((occupy & 8070450532247928832) == 0) result |= 576460752303423488;
            if ((occupy & 8646911284551352320) == 0) result |= 288230376151711744;
            if ((occupy & 8935141660703064064) == 0) result |= 144115188075855872;
            if ((occupy & 9079256848778919936) == 0) result |= 72057594037927936;
            return result;
        },
        else => {
            unreachable;
        },
    }
}

fn getSliderVCond(slider_square: u64, occupy: u64) u64 {
    var result: u64 = 0;
    switch (slider_square) {
        0 => {
            result = 256;
            if ((occupy & 256) == 0) result |= 65536;
            if ((occupy & 65792) == 0) result |= 16777216;
            if ((occupy & 16843008) == 0) result |= 4294967296;
            if ((occupy & 4311810304) == 0) result |= 1099511627776;
            if ((occupy & 1103823438080) == 0) result |= 281474976710656;
            if ((occupy & 282578800148736) == 0) result |= 72057594037927936;
            return result;
        },
        1 => {
            result = 512;
            if ((occupy & 512) == 0) result |= 131072;
            if ((occupy & 131584) == 0) result |= 33554432;
            if ((occupy & 33686016) == 0) result |= 8589934592;
            if ((occupy & 8623620608) == 0) result |= 2199023255552;
            if ((occupy & 2207646876160) == 0) result |= 562949953421312;
            if ((occupy & 565157600297472) == 0) result |= 144115188075855872;
            return result;
        },
        2 => {
            result = 1024;
            if ((occupy & 1024) == 0) result |= 262144;
            if ((occupy & 263168) == 0) result |= 67108864;
            if ((occupy & 67372032) == 0) result |= 17179869184;
            if ((occupy & 17247241216) == 0) result |= 4398046511104;
            if ((occupy & 4415293752320) == 0) result |= 1125899906842624;
            if ((occupy & 1130315200594944) == 0) result |= 288230376151711744;
            return result;
        },
        3 => {
            result = 2048;
            if ((occupy & 2048) == 0) result |= 524288;
            if ((occupy & 526336) == 0) result |= 134217728;
            if ((occupy & 134744064) == 0) result |= 34359738368;
            if ((occupy & 34494482432) == 0) result |= 8796093022208;
            if ((occupy & 8830587504640) == 0) result |= 2251799813685248;
            if ((occupy & 2260630401189888) == 0) result |= 576460752303423488;
            return result;
        },
        4 => {
            result = 4096;
            if ((occupy & 4096) == 0) result |= 1048576;
            if ((occupy & 1052672) == 0) result |= 268435456;
            if ((occupy & 269488128) == 0) result |= 68719476736;
            if ((occupy & 68988964864) == 0) result |= 17592186044416;
            if ((occupy & 17661175009280) == 0) result |= 4503599627370496;
            if ((occupy & 4521260802379776) == 0) result |= 1152921504606846976;
            return result;
        },
        5 => {
            result = 8192;
            if ((occupy & 8192) == 0) result |= 2097152;
            if ((occupy & 2105344) == 0) result |= 536870912;
            if ((occupy & 538976256) == 0) result |= 137438953472;
            if ((occupy & 137977929728) == 0) result |= 35184372088832;
            if ((occupy & 35322350018560) == 0) result |= 9007199254740992;
            if ((occupy & 9042521604759552) == 0) result |= 2305843009213693952;
            return result;
        },
        6 => {
            result = 16384;
            if ((occupy & 16384) == 0) result |= 4194304;
            if ((occupy & 4210688) == 0) result |= 1073741824;
            if ((occupy & 1077952512) == 0) result |= 274877906944;
            if ((occupy & 275955859456) == 0) result |= 70368744177664;
            if ((occupy & 70644700037120) == 0) result |= 18014398509481984;
            if ((occupy & 18085043209519104) == 0) result |= 4611686018427387904;
            return result;
        },
        7 => {
            result = 32768;
            if ((occupy & 32768) == 0) result |= 8388608;
            if ((occupy & 8421376) == 0) result |= 2147483648;
            if ((occupy & 2155905024) == 0) result |= 549755813888;
            if ((occupy & 551911718912) == 0) result |= 140737488355328;
            if ((occupy & 141289400074240) == 0) result |= 36028797018963968;
            if ((occupy & 36170086419038208) == 0) result |= 9223372036854775808;
            return result;
        },
        8 => {
            result = 65537;
            if ((occupy & 65536) == 0) result |= 16777216;
            if ((occupy & 16842752) == 0) result |= 4294967296;
            if ((occupy & 4311810048) == 0) result |= 1099511627776;
            if ((occupy & 1103823437824) == 0) result |= 281474976710656;
            if ((occupy & 282578800148480) == 0) result |= 72057594037927936;
            return result;
        },
        9 => {
            result = 131074;
            if ((occupy & 131072) == 0) result |= 33554432;
            if ((occupy & 33685504) == 0) result |= 8589934592;
            if ((occupy & 8623620096) == 0) result |= 2199023255552;
            if ((occupy & 2207646875648) == 0) result |= 562949953421312;
            if ((occupy & 565157600296960) == 0) result |= 144115188075855872;
            return result;
        },
        10 => {
            result = 262148;
            if ((occupy & 262144) == 0) result |= 67108864;
            if ((occupy & 67371008) == 0) result |= 17179869184;
            if ((occupy & 17247240192) == 0) result |= 4398046511104;
            if ((occupy & 4415293751296) == 0) result |= 1125899906842624;
            if ((occupy & 1130315200593920) == 0) result |= 288230376151711744;
            return result;
        },
        11 => {
            result = 524296;
            if ((occupy & 524288) == 0) result |= 134217728;
            if ((occupy & 134742016) == 0) result |= 34359738368;
            if ((occupy & 34494480384) == 0) result |= 8796093022208;
            if ((occupy & 8830587502592) == 0) result |= 2251799813685248;
            if ((occupy & 2260630401187840) == 0) result |= 576460752303423488;
            return result;
        },
        12 => {
            result = 1048592;
            if ((occupy & 1048576) == 0) result |= 268435456;
            if ((occupy & 269484032) == 0) result |= 68719476736;
            if ((occupy & 68988960768) == 0) result |= 17592186044416;
            if ((occupy & 17661175005184) == 0) result |= 4503599627370496;
            if ((occupy & 4521260802375680) == 0) result |= 1152921504606846976;
            return result;
        },
        13 => {
            result = 2097184;
            if ((occupy & 2097152) == 0) result |= 536870912;
            if ((occupy & 538968064) == 0) result |= 137438953472;
            if ((occupy & 137977921536) == 0) result |= 35184372088832;
            if ((occupy & 35322350010368) == 0) result |= 9007199254740992;
            if ((occupy & 9042521604751360) == 0) result |= 2305843009213693952;
            return result;
        },
        14 => {
            result = 4194368;
            if ((occupy & 4194304) == 0) result |= 1073741824;
            if ((occupy & 1077936128) == 0) result |= 274877906944;
            if ((occupy & 275955843072) == 0) result |= 70368744177664;
            if ((occupy & 70644700020736) == 0) result |= 18014398509481984;
            if ((occupy & 18085043209502720) == 0) result |= 4611686018427387904;
            return result;
        },
        15 => {
            result = 8388736;
            if ((occupy & 8388608) == 0) result |= 2147483648;
            if ((occupy & 2155872256) == 0) result |= 549755813888;
            if ((occupy & 551911686144) == 0) result |= 140737488355328;
            if ((occupy & 141289400041472) == 0) result |= 36028797018963968;
            if ((occupy & 36170086419005440) == 0) result |= 9223372036854775808;
            return result;
        },
        16 => {
            result = 16777472;
            if ((occupy & 256) == 0) result |= 1;
            if ((occupy & 16777216) == 0) result |= 4294967296;
            if ((occupy & 4311744512) == 0) result |= 1099511627776;
            if ((occupy & 1103823372288) == 0) result |= 281474976710656;
            if ((occupy & 282578800082944) == 0) result |= 72057594037927936;
            return result;
        },
        17 => {
            result = 33554944;
            if ((occupy & 512) == 0) result |= 2;
            if ((occupy & 33554432) == 0) result |= 8589934592;
            if ((occupy & 8623489024) == 0) result |= 2199023255552;
            if ((occupy & 2207646744576) == 0) result |= 562949953421312;
            if ((occupy & 565157600165888) == 0) result |= 144115188075855872;
            return result;
        },
        18 => {
            result = 67109888;
            if ((occupy & 1024) == 0) result |= 4;
            if ((occupy & 67108864) == 0) result |= 17179869184;
            if ((occupy & 17246978048) == 0) result |= 4398046511104;
            if ((occupy & 4415293489152) == 0) result |= 1125899906842624;
            if ((occupy & 1130315200331776) == 0) result |= 288230376151711744;
            return result;
        },
        19 => {
            result = 134219776;
            if ((occupy & 2048) == 0) result |= 8;
            if ((occupy & 134217728) == 0) result |= 34359738368;
            if ((occupy & 34493956096) == 0) result |= 8796093022208;
            if ((occupy & 8830586978304) == 0) result |= 2251799813685248;
            if ((occupy & 2260630400663552) == 0) result |= 576460752303423488;
            return result;
        },
        20 => {
            result = 268439552;
            if ((occupy & 4096) == 0) result |= 16;
            if ((occupy & 268435456) == 0) result |= 68719476736;
            if ((occupy & 68987912192) == 0) result |= 17592186044416;
            if ((occupy & 17661173956608) == 0) result |= 4503599627370496;
            if ((occupy & 4521260801327104) == 0) result |= 1152921504606846976;
            return result;
        },
        21 => {
            result = 536879104;
            if ((occupy & 8192) == 0) result |= 32;
            if ((occupy & 536870912) == 0) result |= 137438953472;
            if ((occupy & 137975824384) == 0) result |= 35184372088832;
            if ((occupy & 35322347913216) == 0) result |= 9007199254740992;
            if ((occupy & 9042521602654208) == 0) result |= 2305843009213693952;
            return result;
        },
        22 => {
            result = 1073758208;
            if ((occupy & 16384) == 0) result |= 64;
            if ((occupy & 1073741824) == 0) result |= 274877906944;
            if ((occupy & 275951648768) == 0) result |= 70368744177664;
            if ((occupy & 70644695826432) == 0) result |= 18014398509481984;
            if ((occupy & 18085043205308416) == 0) result |= 4611686018427387904;
            return result;
        },
        23 => {
            result = 2147516416;
            if ((occupy & 32768) == 0) result |= 128;
            if ((occupy & 2147483648) == 0) result |= 549755813888;
            if ((occupy & 551903297536) == 0) result |= 140737488355328;
            if ((occupy & 141289391652864) == 0) result |= 36028797018963968;
            if ((occupy & 36170086410616832) == 0) result |= 9223372036854775808;
            return result;
        },
        24 => {
            result = 4295032832;
            if ((occupy & 65536) == 0) result |= 256;
            if ((occupy & 65792) == 0) result |= 1;
            if ((occupy & 4294967296) == 0) result |= 1099511627776;
            if ((occupy & 1103806595072) == 0) result |= 281474976710656;
            if ((occupy & 282578783305728) == 0) result |= 72057594037927936;
            return result;
        },
        25 => {
            result = 8590065664;
            if ((occupy & 131072) == 0) result |= 512;
            if ((occupy & 131584) == 0) result |= 2;
            if ((occupy & 8589934592) == 0) result |= 2199023255552;
            if ((occupy & 2207613190144) == 0) result |= 562949953421312;
            if ((occupy & 565157566611456) == 0) result |= 144115188075855872;
            return result;
        },
        26 => {
            result = 17180131328;
            if ((occupy & 262144) == 0) result |= 1024;
            if ((occupy & 263168) == 0) result |= 4;
            if ((occupy & 17179869184) == 0) result |= 4398046511104;
            if ((occupy & 4415226380288) == 0) result |= 1125899906842624;
            if ((occupy & 1130315133222912) == 0) result |= 288230376151711744;
            return result;
        },
        27 => {
            result = 34360262656;
            if ((occupy & 524288) == 0) result |= 2048;
            if ((occupy & 526336) == 0) result |= 8;
            if ((occupy & 34359738368) == 0) result |= 8796093022208;
            if ((occupy & 8830452760576) == 0) result |= 2251799813685248;
            if ((occupy & 2260630266445824) == 0) result |= 576460752303423488;
            return result;
        },
        28 => {
            result = 68720525312;
            if ((occupy & 1048576) == 0) result |= 4096;
            if ((occupy & 1052672) == 0) result |= 16;
            if ((occupy & 68719476736) == 0) result |= 17592186044416;
            if ((occupy & 17660905521152) == 0) result |= 4503599627370496;
            if ((occupy & 4521260532891648) == 0) result |= 1152921504606846976;
            return result;
        },
        29 => {
            result = 137441050624;
            if ((occupy & 2097152) == 0) result |= 8192;
            if ((occupy & 2105344) == 0) result |= 32;
            if ((occupy & 137438953472) == 0) result |= 35184372088832;
            if ((occupy & 35321811042304) == 0) result |= 9007199254740992;
            if ((occupy & 9042521065783296) == 0) result |= 2305843009213693952;
            return result;
        },
        30 => {
            result = 274882101248;
            if ((occupy & 4194304) == 0) result |= 16384;
            if ((occupy & 4210688) == 0) result |= 64;
            if ((occupy & 274877906944) == 0) result |= 70368744177664;
            if ((occupy & 70643622084608) == 0) result |= 18014398509481984;
            if ((occupy & 18085042131566592) == 0) result |= 4611686018427387904;
            return result;
        },
        31 => {
            result = 549764202496;
            if ((occupy & 8388608) == 0) result |= 32768;
            if ((occupy & 8421376) == 0) result |= 128;
            if ((occupy & 549755813888) == 0) result |= 140737488355328;
            if ((occupy & 141287244169216) == 0) result |= 36028797018963968;
            if ((occupy & 36170084263133184) == 0) result |= 9223372036854775808;
            return result;
        },
        32 => {
            result = 1099528404992;
            if ((occupy & 16777216) == 0) result |= 65536;
            if ((occupy & 16842752) == 0) result |= 256;
            if ((occupy & 16843008) == 0) result |= 1;
            if ((occupy & 1099511627776) == 0) result |= 281474976710656;
            if ((occupy & 282574488338432) == 0) result |= 72057594037927936;
            return result;
        },
        33 => {
            result = 2199056809984;
            if ((occupy & 33554432) == 0) result |= 131072;
            if ((occupy & 33685504) == 0) result |= 512;
            if ((occupy & 33686016) == 0) result |= 2;
            if ((occupy & 2199023255552) == 0) result |= 562949953421312;
            if ((occupy & 565148976676864) == 0) result |= 144115188075855872;
            return result;
        },
        34 => {
            result = 4398113619968;
            if ((occupy & 67108864) == 0) result |= 262144;
            if ((occupy & 67371008) == 0) result |= 1024;
            if ((occupy & 67372032) == 0) result |= 4;
            if ((occupy & 4398046511104) == 0) result |= 1125899906842624;
            if ((occupy & 1130297953353728) == 0) result |= 288230376151711744;
            return result;
        },
        35 => {
            result = 8796227239936;
            if ((occupy & 134217728) == 0) result |= 524288;
            if ((occupy & 134742016) == 0) result |= 2048;
            if ((occupy & 134744064) == 0) result |= 8;
            if ((occupy & 8796093022208) == 0) result |= 2251799813685248;
            if ((occupy & 2260595906707456) == 0) result |= 576460752303423488;
            return result;
        },
        36 => {
            result = 17592454479872;
            if ((occupy & 268435456) == 0) result |= 1048576;
            if ((occupy & 269484032) == 0) result |= 4096;
            if ((occupy & 269488128) == 0) result |= 16;
            if ((occupy & 17592186044416) == 0) result |= 4503599627370496;
            if ((occupy & 4521191813414912) == 0) result |= 1152921504606846976;
            return result;
        },
        37 => {
            result = 35184908959744;
            if ((occupy & 536870912) == 0) result |= 2097152;
            if ((occupy & 538968064) == 0) result |= 8192;
            if ((occupy & 538976256) == 0) result |= 32;
            if ((occupy & 35184372088832) == 0) result |= 9007199254740992;
            if ((occupy & 9042383626829824) == 0) result |= 2305843009213693952;
            return result;
        },
        38 => {
            result = 70369817919488;
            if ((occupy & 1073741824) == 0) result |= 4194304;
            if ((occupy & 1077936128) == 0) result |= 16384;
            if ((occupy & 1077952512) == 0) result |= 64;
            if ((occupy & 70368744177664) == 0) result |= 18014398509481984;
            if ((occupy & 18084767253659648) == 0) result |= 4611686018427387904;
            return result;
        },
        39 => {
            result = 140739635838976;
            if ((occupy & 2147483648) == 0) result |= 8388608;
            if ((occupy & 2155872256) == 0) result |= 32768;
            if ((occupy & 2155905024) == 0) result |= 128;
            if ((occupy & 140737488355328) == 0) result |= 36028797018963968;
            if ((occupy & 36169534507319296) == 0) result |= 9223372036854775808;
            return result;
        },
        40 => {
            result = 281479271677952;
            if ((occupy & 4294967296) == 0) result |= 16777216;
            if ((occupy & 4311744512) == 0) result |= 65536;
            if ((occupy & 4311810048) == 0) result |= 256;
            if ((occupy & 4311810304) == 0) result |= 1;
            if ((occupy & 281474976710656) == 0) result |= 72057594037927936;
            return result;
        },
        41 => {
            result = 562958543355904;
            if ((occupy & 8589934592) == 0) result |= 33554432;
            if ((occupy & 8623489024) == 0) result |= 131072;
            if ((occupy & 8623620096) == 0) result |= 512;
            if ((occupy & 8623620608) == 0) result |= 2;
            if ((occupy & 562949953421312) == 0) result |= 144115188075855872;
            return result;
        },
        42 => {
            result = 1125917086711808;
            if ((occupy & 17179869184) == 0) result |= 67108864;
            if ((occupy & 17246978048) == 0) result |= 262144;
            if ((occupy & 17247240192) == 0) result |= 1024;
            if ((occupy & 17247241216) == 0) result |= 4;
            if ((occupy & 1125899906842624) == 0) result |= 288230376151711744;
            return result;
        },
        43 => {
            result = 2251834173423616;
            if ((occupy & 34359738368) == 0) result |= 134217728;
            if ((occupy & 34493956096) == 0) result |= 524288;
            if ((occupy & 34494480384) == 0) result |= 2048;
            if ((occupy & 34494482432) == 0) result |= 8;
            if ((occupy & 2251799813685248) == 0) result |= 576460752303423488;
            return result;
        },
        44 => {
            result = 4503668346847232;
            if ((occupy & 68719476736) == 0) result |= 268435456;
            if ((occupy & 68987912192) == 0) result |= 1048576;
            if ((occupy & 68988960768) == 0) result |= 4096;
            if ((occupy & 68988964864) == 0) result |= 16;
            if ((occupy & 4503599627370496) == 0) result |= 1152921504606846976;
            return result;
        },
        45 => {
            result = 9007336693694464;
            if ((occupy & 137438953472) == 0) result |= 536870912;
            if ((occupy & 137975824384) == 0) result |= 2097152;
            if ((occupy & 137977921536) == 0) result |= 8192;
            if ((occupy & 137977929728) == 0) result |= 32;
            if ((occupy & 9007199254740992) == 0) result |= 2305843009213693952;
            return result;
        },
        46 => {
            result = 18014673387388928;
            if ((occupy & 274877906944) == 0) result |= 1073741824;
            if ((occupy & 275951648768) == 0) result |= 4194304;
            if ((occupy & 275955843072) == 0) result |= 16384;
            if ((occupy & 275955859456) == 0) result |= 64;
            if ((occupy & 18014398509481984) == 0) result |= 4611686018427387904;
            return result;
        },
        47 => {
            result = 36029346774777856;
            if ((occupy & 549755813888) == 0) result |= 2147483648;
            if ((occupy & 551903297536) == 0) result |= 8388608;
            if ((occupy & 551911686144) == 0) result |= 32768;
            if ((occupy & 551911718912) == 0) result |= 128;
            if ((occupy & 36028797018963968) == 0) result |= 9223372036854775808;
            return result;
        },
        48 => {
            result = 72058693549555712;
            if ((occupy & 1099511627776) == 0) result |= 4294967296;
            if ((occupy & 1103806595072) == 0) result |= 16777216;
            if ((occupy & 1103823372288) == 0) result |= 65536;
            if ((occupy & 1103823437824) == 0) result |= 256;
            if ((occupy & 1103823438080) == 0) result |= 1;
            return result;
        },
        49 => {
            result = 144117387099111424;
            if ((occupy & 2199023255552) == 0) result |= 8589934592;
            if ((occupy & 2207613190144) == 0) result |= 33554432;
            if ((occupy & 2207646744576) == 0) result |= 131072;
            if ((occupy & 2207646875648) == 0) result |= 512;
            if ((occupy & 2207646876160) == 0) result |= 2;
            return result;
        },
        50 => {
            result = 288234774198222848;
            if ((occupy & 4398046511104) == 0) result |= 17179869184;
            if ((occupy & 4415226380288) == 0) result |= 67108864;
            if ((occupy & 4415293489152) == 0) result |= 262144;
            if ((occupy & 4415293751296) == 0) result |= 1024;
            if ((occupy & 4415293752320) == 0) result |= 4;
            return result;
        },
        51 => {
            result = 576469548396445696;
            if ((occupy & 8796093022208) == 0) result |= 34359738368;
            if ((occupy & 8830452760576) == 0) result |= 134217728;
            if ((occupy & 8830586978304) == 0) result |= 524288;
            if ((occupy & 8830587502592) == 0) result |= 2048;
            if ((occupy & 8830587504640) == 0) result |= 8;
            return result;
        },
        52 => {
            result = 1152939096792891392;
            if ((occupy & 17592186044416) == 0) result |= 68719476736;
            if ((occupy & 17660905521152) == 0) result |= 268435456;
            if ((occupy & 17661173956608) == 0) result |= 1048576;
            if ((occupy & 17661175005184) == 0) result |= 4096;
            if ((occupy & 17661175009280) == 0) result |= 16;
            return result;
        },
        53 => {
            result = 2305878193585782784;
            if ((occupy & 35184372088832) == 0) result |= 137438953472;
            if ((occupy & 35321811042304) == 0) result |= 536870912;
            if ((occupy & 35322347913216) == 0) result |= 2097152;
            if ((occupy & 35322350010368) == 0) result |= 8192;
            if ((occupy & 35322350018560) == 0) result |= 32;
            return result;
        },
        54 => {
            result = 4611756387171565568;
            if ((occupy & 70368744177664) == 0) result |= 274877906944;
            if ((occupy & 70643622084608) == 0) result |= 1073741824;
            if ((occupy & 70644695826432) == 0) result |= 4194304;
            if ((occupy & 70644700020736) == 0) result |= 16384;
            if ((occupy & 70644700037120) == 0) result |= 64;
            return result;
        },
        55 => {
            result = 9223512774343131136;
            if ((occupy & 140737488355328) == 0) result |= 549755813888;
            if ((occupy & 141287244169216) == 0) result |= 2147483648;
            if ((occupy & 141289391652864) == 0) result |= 8388608;
            if ((occupy & 141289400041472) == 0) result |= 32768;
            if ((occupy & 141289400074240) == 0) result |= 128;
            return result;
        },
        56 => {
            result = 281474976710656;
            if ((occupy & 281474976710656) == 0) result |= 1099511627776;
            if ((occupy & 282574488338432) == 0) result |= 4294967296;
            if ((occupy & 282578783305728) == 0) result |= 16777216;
            if ((occupy & 282578800082944) == 0) result |= 65536;
            if ((occupy & 282578800148480) == 0) result |= 256;
            if ((occupy & 282578800148736) == 0) result |= 1;
            return result;
        },
        57 => {
            result = 562949953421312;
            if ((occupy & 562949953421312) == 0) result |= 2199023255552;
            if ((occupy & 565148976676864) == 0) result |= 8589934592;
            if ((occupy & 565157566611456) == 0) result |= 33554432;
            if ((occupy & 565157600165888) == 0) result |= 131072;
            if ((occupy & 565157600296960) == 0) result |= 512;
            if ((occupy & 565157600297472) == 0) result |= 2;
            return result;
        },
        58 => {
            result = 1125899906842624;
            if ((occupy & 1125899906842624) == 0) result |= 4398046511104;
            if ((occupy & 1130297953353728) == 0) result |= 17179869184;
            if ((occupy & 1130315133222912) == 0) result |= 67108864;
            if ((occupy & 1130315200331776) == 0) result |= 262144;
            if ((occupy & 1130315200593920) == 0) result |= 1024;
            if ((occupy & 1130315200594944) == 0) result |= 4;
            return result;
        },
        59 => {
            result = 2251799813685248;
            if ((occupy & 2251799813685248) == 0) result |= 8796093022208;
            if ((occupy & 2260595906707456) == 0) result |= 34359738368;
            if ((occupy & 2260630266445824) == 0) result |= 134217728;
            if ((occupy & 2260630400663552) == 0) result |= 524288;
            if ((occupy & 2260630401187840) == 0) result |= 2048;
            if ((occupy & 2260630401189888) == 0) result |= 8;
            return result;
        },
        60 => {
            result = 4503599627370496;
            if ((occupy & 4503599627370496) == 0) result |= 17592186044416;
            if ((occupy & 4521191813414912) == 0) result |= 68719476736;
            if ((occupy & 4521260532891648) == 0) result |= 268435456;
            if ((occupy & 4521260801327104) == 0) result |= 1048576;
            if ((occupy & 4521260802375680) == 0) result |= 4096;
            if ((occupy & 4521260802379776) == 0) result |= 16;
            return result;
        },
        61 => {
            result = 9007199254740992;
            if ((occupy & 9007199254740992) == 0) result |= 35184372088832;
            if ((occupy & 9042383626829824) == 0) result |= 137438953472;
            if ((occupy & 9042521065783296) == 0) result |= 536870912;
            if ((occupy & 9042521602654208) == 0) result |= 2097152;
            if ((occupy & 9042521604751360) == 0) result |= 8192;
            if ((occupy & 9042521604759552) == 0) result |= 32;
            return result;
        },
        62 => {
            result = 18014398509481984;
            if ((occupy & 18014398509481984) == 0) result |= 70368744177664;
            if ((occupy & 18084767253659648) == 0) result |= 274877906944;
            if ((occupy & 18085042131566592) == 0) result |= 1073741824;
            if ((occupy & 18085043205308416) == 0) result |= 4194304;
            if ((occupy & 18085043209502720) == 0) result |= 16384;
            if ((occupy & 18085043209519104) == 0) result |= 64;
            return result;
        },
        63 => {
            result = 36028797018963968;
            if ((occupy & 36028797018963968) == 0) result |= 140737488355328;
            if ((occupy & 36169534507319296) == 0) result |= 549755813888;
            if ((occupy & 36170084263133184) == 0) result |= 2147483648;
            if ((occupy & 36170086410616832) == 0) result |= 8388608;
            if ((occupy & 36170086419005440) == 0) result |= 32768;
            if ((occupy & 36170086419038208) == 0) result |= 128;
            return result;
        },
        else => {
            unreachable;
        },
    }
}

fn getSliderD2Cond(slider_square: u64, occupy: u64) u64 {
    var result: u64 = 0;
    switch (slider_square) {
        0 => {
            result = 0;
            return result;
        },
        1 => {
            result = 256;
            return result;
        },
        2 => {
            result = 512;
            if ((occupy & 512) == 0) result |= 65536;
            return result;
        },
        3 => {
            result = 1024;
            if ((occupy & 1024) == 0) result |= 131072;
            if ((occupy & 132096) == 0) result |= 16777216;
            return result;
        },
        4 => {
            result = 2048;
            if ((occupy & 2048) == 0) result |= 262144;
            if ((occupy & 264192) == 0) result |= 33554432;
            if ((occupy & 33818624) == 0) result |= 4294967296;
            return result;
        },
        5 => {
            result = 4096;
            if ((occupy & 4096) == 0) result |= 524288;
            if ((occupy & 528384) == 0) result |= 67108864;
            if ((occupy & 67637248) == 0) result |= 8589934592;
            if ((occupy & 8657571840) == 0) result |= 1099511627776;
            return result;
        },
        6 => {
            result = 8192;
            if ((occupy & 8192) == 0) result |= 1048576;
            if ((occupy & 1056768) == 0) result |= 134217728;
            if ((occupy & 135274496) == 0) result |= 17179869184;
            if ((occupy & 17315143680) == 0) result |= 2199023255552;
            if ((occupy & 2216338399232) == 0) result |= 281474976710656;
            return result;
        },
        7 => {
            result = 16384;
            if ((occupy & 16384) == 0) result |= 2097152;
            if ((occupy & 2113536) == 0) result |= 268435456;
            if ((occupy & 270548992) == 0) result |= 34359738368;
            if ((occupy & 34630287360) == 0) result |= 4398046511104;
            if ((occupy & 4432676798464) == 0) result |= 562949953421312;
            if ((occupy & 567382630219776) == 0) result |= 72057594037927936;
            return result;
        },
        8 => {
            result = 2;
            return result;
        },
        9 => {
            result = 65540;
            return result;
        },
        10 => {
            result = 131080;
            if ((occupy & 131072) == 0) result |= 16777216;
            return result;
        },
        11 => {
            result = 262160;
            if ((occupy & 262144) == 0) result |= 33554432;
            if ((occupy & 33816576) == 0) result |= 4294967296;
            return result;
        },
        12 => {
            result = 524320;
            if ((occupy & 524288) == 0) result |= 67108864;
            if ((occupy & 67633152) == 0) result |= 8589934592;
            if ((occupy & 8657567744) == 0) result |= 1099511627776;
            return result;
        },
        13 => {
            result = 1048640;
            if ((occupy & 1048576) == 0) result |= 134217728;
            if ((occupy & 135266304) == 0) result |= 17179869184;
            if ((occupy & 17315135488) == 0) result |= 2199023255552;
            if ((occupy & 2216338391040) == 0) result |= 281474976710656;
            return result;
        },
        14 => {
            result = 2097280;
            if ((occupy & 2097152) == 0) result |= 268435456;
            if ((occupy & 270532608) == 0) result |= 34359738368;
            if ((occupy & 34630270976) == 0) result |= 4398046511104;
            if ((occupy & 4432676782080) == 0) result |= 562949953421312;
            if ((occupy & 567382630203392) == 0) result |= 72057594037927936;
            return result;
        },
        15 => {
            result = 4194304;
            if ((occupy & 4194304) == 0) result |= 536870912;
            if ((occupy & 541065216) == 0) result |= 68719476736;
            if ((occupy & 69260541952) == 0) result |= 8796093022208;
            if ((occupy & 8865353564160) == 0) result |= 1125899906842624;
            if ((occupy & 1134765260406784) == 0) result |= 144115188075855872;
            return result;
        },
        16 => {
            result = 512;
            if ((occupy & 512) == 0) result |= 4;
            return result;
        },
        17 => {
            result = 16778240;
            if ((occupy & 1024) == 0) result |= 8;
            return result;
        },
        18 => {
            result = 33556480;
            if ((occupy & 2048) == 0) result |= 16;
            if ((occupy & 33554432) == 0) result |= 4294967296;
            return result;
        },
        19 => {
            result = 67112960;
            if ((occupy & 4096) == 0) result |= 32;
            if ((occupy & 67108864) == 0) result |= 8589934592;
            if ((occupy & 8657043456) == 0) result |= 1099511627776;
            return result;
        },
        20 => {
            result = 134225920;
            if ((occupy & 8192) == 0) result |= 64;
            if ((occupy & 134217728) == 0) result |= 17179869184;
            if ((occupy & 17314086912) == 0) result |= 2199023255552;
            if ((occupy & 2216337342464) == 0) result |= 281474976710656;
            return result;
        },
        21 => {
            result = 268451840;
            if ((occupy & 16384) == 0) result |= 128;
            if ((occupy & 268435456) == 0) result |= 34359738368;
            if ((occupy & 34628173824) == 0) result |= 4398046511104;
            if ((occupy & 4432674684928) == 0) result |= 562949953421312;
            if ((occupy & 567382628106240) == 0) result |= 72057594037927936;
            return result;
        },
        22 => {
            result = 536903680;
            if ((occupy & 536870912) == 0) result |= 68719476736;
            if ((occupy & 69256347648) == 0) result |= 8796093022208;
            if ((occupy & 8865349369856) == 0) result |= 1125899906842624;
            if ((occupy & 1134765256212480) == 0) result |= 144115188075855872;
            return result;
        },
        23 => {
            result = 1073741824;
            if ((occupy & 1073741824) == 0) result |= 137438953472;
            if ((occupy & 138512695296) == 0) result |= 17592186044416;
            if ((occupy & 17730698739712) == 0) result |= 2251799813685248;
            if ((occupy & 2269530512424960) == 0) result |= 288230376151711744;
            return result;
        },
        24 => {
            result = 131072;
            if ((occupy & 131072) == 0) result |= 1024;
            if ((occupy & 132096) == 0) result |= 8;
            return result;
        },
        25 => {
            result = 4295229440;
            if ((occupy & 262144) == 0) result |= 2048;
            if ((occupy & 264192) == 0) result |= 16;
            return result;
        },
        26 => {
            result = 8590458880;
            if ((occupy & 524288) == 0) result |= 4096;
            if ((occupy & 528384) == 0) result |= 32;
            if ((occupy & 8589934592) == 0) result |= 1099511627776;
            return result;
        },
        27 => {
            result = 17180917760;
            if ((occupy & 1048576) == 0) result |= 8192;
            if ((occupy & 1056768) == 0) result |= 64;
            if ((occupy & 17179869184) == 0) result |= 2199023255552;
            if ((occupy & 2216203124736) == 0) result |= 281474976710656;
            return result;
        },
        28 => {
            result = 34361835520;
            if ((occupy & 2097152) == 0) result |= 16384;
            if ((occupy & 2113536) == 0) result |= 128;
            if ((occupy & 34359738368) == 0) result |= 4398046511104;
            if ((occupy & 4432406249472) == 0) result |= 562949953421312;
            if ((occupy & 567382359670784) == 0) result |= 72057594037927936;
            return result;
        },
        29 => {
            result = 68723671040;
            if ((occupy & 4194304) == 0) result |= 32768;
            if ((occupy & 68719476736) == 0) result |= 8796093022208;
            if ((occupy & 8864812498944) == 0) result |= 1125899906842624;
            if ((occupy & 1134764719341568) == 0) result |= 144115188075855872;
            return result;
        },
        30 => {
            result = 137447342080;
            if ((occupy & 137438953472) == 0) result |= 17592186044416;
            if ((occupy & 17729624997888) == 0) result |= 2251799813685248;
            if ((occupy & 2269529438683136) == 0) result |= 288230376151711744;
            return result;
        },
        31 => {
            result = 274877906944;
            if ((occupy & 274877906944) == 0) result |= 35184372088832;
            if ((occupy & 35459249995776) == 0) result |= 4503599627370496;
            if ((occupy & 4539058877366272) == 0) result |= 576460752303423488;
            return result;
        },
        32 => {
            result = 33554432;
            if ((occupy & 33554432) == 0) result |= 262144;
            if ((occupy & 33816576) == 0) result |= 2048;
            if ((occupy & 33818624) == 0) result |= 16;
            return result;
        },
        33 => {
            result = 1099578736640;
            if ((occupy & 67108864) == 0) result |= 524288;
            if ((occupy & 67633152) == 0) result |= 4096;
            if ((occupy & 67637248) == 0) result |= 32;
            return result;
        },
        34 => {
            result = 2199157473280;
            if ((occupy & 134217728) == 0) result |= 1048576;
            if ((occupy & 135266304) == 0) result |= 8192;
            if ((occupy & 135274496) == 0) result |= 64;
            if ((occupy & 2199023255552) == 0) result |= 281474976710656;
            return result;
        },
        35 => {
            result = 4398314946560;
            if ((occupy & 268435456) == 0) result |= 2097152;
            if ((occupy & 270532608) == 0) result |= 16384;
            if ((occupy & 270548992) == 0) result |= 128;
            if ((occupy & 4398046511104) == 0) result |= 562949953421312;
            if ((occupy & 567347999932416) == 0) result |= 72057594037927936;
            return result;
        },
        36 => {
            result = 8796629893120;
            if ((occupy & 536870912) == 0) result |= 4194304;
            if ((occupy & 541065216) == 0) result |= 32768;
            if ((occupy & 8796093022208) == 0) result |= 1125899906842624;
            if ((occupy & 1134695999864832) == 0) result |= 144115188075855872;
            return result;
        },
        37 => {
            result = 17593259786240;
            if ((occupy & 1073741824) == 0) result |= 8388608;
            if ((occupy & 17592186044416) == 0) result |= 2251799813685248;
            if ((occupy & 2269391999729664) == 0) result |= 288230376151711744;
            return result;
        },
        38 => {
            result = 35186519572480;
            if ((occupy & 35184372088832) == 0) result |= 4503599627370496;
            if ((occupy & 4538783999459328) == 0) result |= 576460752303423488;
            return result;
        },
        39 => {
            result = 70368744177664;
            if ((occupy & 70368744177664) == 0) result |= 9007199254740992;
            if ((occupy & 9077567998918656) == 0) result |= 1152921504606846976;
            return result;
        },
        40 => {
            result = 8589934592;
            if ((occupy & 8589934592) == 0) result |= 67108864;
            if ((occupy & 8657043456) == 0) result |= 524288;
            if ((occupy & 8657567744) == 0) result |= 4096;
            if ((occupy & 8657571840) == 0) result |= 32;
            return result;
        },
        41 => {
            result = 281492156579840;
            if ((occupy & 17179869184) == 0) result |= 134217728;
            if ((occupy & 17314086912) == 0) result |= 1048576;
            if ((occupy & 17315135488) == 0) result |= 8192;
            if ((occupy & 17315143680) == 0) result |= 64;
            return result;
        },
        42 => {
            result = 562984313159680;
            if ((occupy & 34359738368) == 0) result |= 268435456;
            if ((occupy & 34628173824) == 0) result |= 2097152;
            if ((occupy & 34630270976) == 0) result |= 16384;
            if ((occupy & 34630287360) == 0) result |= 128;
            if ((occupy & 562949953421312) == 0) result |= 72057594037927936;
            return result;
        },
        43 => {
            result = 1125968626319360;
            if ((occupy & 68719476736) == 0) result |= 536870912;
            if ((occupy & 69256347648) == 0) result |= 4194304;
            if ((occupy & 69260541952) == 0) result |= 32768;
            if ((occupy & 1125899906842624) == 0) result |= 144115188075855872;
            return result;
        },
        44 => {
            result = 2251937252638720;
            if ((occupy & 137438953472) == 0) result |= 1073741824;
            if ((occupy & 138512695296) == 0) result |= 8388608;
            if ((occupy & 2251799813685248) == 0) result |= 288230376151711744;
            return result;
        },
        45 => {
            result = 4503874505277440;
            if ((occupy & 274877906944) == 0) result |= 2147483648;
            if ((occupy & 4503599627370496) == 0) result |= 576460752303423488;
            return result;
        },
        46 => {
            result = 9007749010554880;
            if ((occupy & 9007199254740992) == 0) result |= 1152921504606846976;
            return result;
        },
        47 => {
            result = 18014398509481984;
            if ((occupy & 18014398509481984) == 0) result |= 2305843009213693952;
            return result;
        },
        48 => {
            result = 2199023255552;
            if ((occupy & 2199023255552) == 0) result |= 17179869184;
            if ((occupy & 2216203124736) == 0) result |= 134217728;
            if ((occupy & 2216337342464) == 0) result |= 1048576;
            if ((occupy & 2216338391040) == 0) result |= 8192;
            if ((occupy & 2216338399232) == 0) result |= 64;
            return result;
        },
        49 => {
            result = 72061992084439040;
            if ((occupy & 4398046511104) == 0) result |= 34359738368;
            if ((occupy & 4432406249472) == 0) result |= 268435456;
            if ((occupy & 4432674684928) == 0) result |= 2097152;
            if ((occupy & 4432676782080) == 0) result |= 16384;
            if ((occupy & 4432676798464) == 0) result |= 128;
            return result;
        },
        50 => {
            result = 144123984168878080;
            if ((occupy & 8796093022208) == 0) result |= 68719476736;
            if ((occupy & 8864812498944) == 0) result |= 536870912;
            if ((occupy & 8865349369856) == 0) result |= 4194304;
            if ((occupy & 8865353564160) == 0) result |= 32768;
            return result;
        },
        51 => {
            result = 288247968337756160;
            if ((occupy & 17592186044416) == 0) result |= 137438953472;
            if ((occupy & 17729624997888) == 0) result |= 1073741824;
            if ((occupy & 17730698739712) == 0) result |= 8388608;
            return result;
        },
        52 => {
            result = 576495936675512320;
            if ((occupy & 35184372088832) == 0) result |= 274877906944;
            if ((occupy & 35459249995776) == 0) result |= 2147483648;
            return result;
        },
        53 => {
            result = 1152991873351024640;
            if ((occupy & 70368744177664) == 0) result |= 549755813888;
            return result;
        },
        54 => {
            result = 2305983746702049280;
            return result;
        },
        55 => {
            result = 4611686018427387904;
            return result;
        },
        56 => {
            result = 562949953421312;
            if ((occupy & 562949953421312) == 0) result |= 4398046511104;
            if ((occupy & 567347999932416) == 0) result |= 34359738368;
            if ((occupy & 567382359670784) == 0) result |= 268435456;
            if ((occupy & 567382628106240) == 0) result |= 2097152;
            if ((occupy & 567382630203392) == 0) result |= 16384;
            if ((occupy & 567382630219776) == 0) result |= 128;
            return result;
        },
        57 => {
            result = 1125899906842624;
            if ((occupy & 1125899906842624) == 0) result |= 8796093022208;
            if ((occupy & 1134695999864832) == 0) result |= 68719476736;
            if ((occupy & 1134764719341568) == 0) result |= 536870912;
            if ((occupy & 1134765256212480) == 0) result |= 4194304;
            if ((occupy & 1134765260406784) == 0) result |= 32768;
            return result;
        },
        58 => {
            result = 2251799813685248;
            if ((occupy & 2251799813685248) == 0) result |= 17592186044416;
            if ((occupy & 2269391999729664) == 0) result |= 137438953472;
            if ((occupy & 2269529438683136) == 0) result |= 1073741824;
            if ((occupy & 2269530512424960) == 0) result |= 8388608;
            return result;
        },
        59 => {
            result = 4503599627370496;
            if ((occupy & 4503599627370496) == 0) result |= 35184372088832;
            if ((occupy & 4538783999459328) == 0) result |= 274877906944;
            if ((occupy & 4539058877366272) == 0) result |= 2147483648;
            return result;
        },
        60 => {
            result = 9007199254740992;
            if ((occupy & 9007199254740992) == 0) result |= 70368744177664;
            if ((occupy & 9077567998918656) == 0) result |= 549755813888;
            return result;
        },
        61 => {
            result = 18014398509481984;
            if ((occupy & 18014398509481984) == 0) result |= 140737488355328;
            return result;
        },
        62 => {
            result = 36028797018963968;
            return result;
        },
        63 => {
            result = 0;
            return result;
        },
        else => {
            unreachable;
        },
    }
}

fn getSliderD1Cond(slider_square: u64, occupy: u64) u64 {
    var result: u64 = 0;
    switch (slider_square) {
        0 => {
            result = 512;
            if ((occupy & 512) == 0) result |= 262144;
            if ((occupy & 262656) == 0) result |= 134217728;
            if ((occupy & 134480384) == 0) result |= 68719476736;
            if ((occupy & 68853957120) == 0) result |= 35184372088832;
            if ((occupy & 35253226045952) == 0) result |= 18014398509481984;
            if ((occupy & 18049651735527936) == 0) result |= 9223372036854775808;
            return result;
        },
        1 => {
            result = 1024;
            if ((occupy & 1024) == 0) result |= 524288;
            if ((occupy & 525312) == 0) result |= 268435456;
            if ((occupy & 268960768) == 0) result |= 137438953472;
            if ((occupy & 137707914240) == 0) result |= 70368744177664;
            if ((occupy & 70506452091904) == 0) result |= 36028797018963968;
            return result;
        },
        2 => {
            result = 2048;
            if ((occupy & 2048) == 0) result |= 1048576;
            if ((occupy & 1050624) == 0) result |= 536870912;
            if ((occupy & 537921536) == 0) result |= 274877906944;
            if ((occupy & 275415828480) == 0) result |= 140737488355328;
            return result;
        },
        3 => {
            result = 4096;
            if ((occupy & 4096) == 0) result |= 2097152;
            if ((occupy & 2101248) == 0) result |= 1073741824;
            if ((occupy & 1075843072) == 0) result |= 549755813888;
            return result;
        },
        4 => {
            result = 8192;
            if ((occupy & 8192) == 0) result |= 4194304;
            if ((occupy & 4202496) == 0) result |= 2147483648;
            return result;
        },
        5 => {
            result = 16384;
            if ((occupy & 16384) == 0) result |= 8388608;
            return result;
        },
        6 => {
            result = 32768;
            return result;
        },
        7 => {
            result = 0;
            return result;
        },
        8 => {
            result = 131072;
            if ((occupy & 131072) == 0) result |= 67108864;
            if ((occupy & 67239936) == 0) result |= 34359738368;
            if ((occupy & 34426978304) == 0) result |= 17592186044416;
            if ((occupy & 17626613022720) == 0) result |= 9007199254740992;
            if ((occupy & 9024825867763712) == 0) result |= 4611686018427387904;
            return result;
        },
        9 => {
            result = 262145;
            if ((occupy & 262144) == 0) result |= 134217728;
            if ((occupy & 134479872) == 0) result |= 68719476736;
            if ((occupy & 68853956608) == 0) result |= 35184372088832;
            if ((occupy & 35253226045440) == 0) result |= 18014398509481984;
            if ((occupy & 18049651735527424) == 0) result |= 9223372036854775808;
            return result;
        },
        10 => {
            result = 524290;
            if ((occupy & 524288) == 0) result |= 268435456;
            if ((occupy & 268959744) == 0) result |= 137438953472;
            if ((occupy & 137707913216) == 0) result |= 70368744177664;
            if ((occupy & 70506452090880) == 0) result |= 36028797018963968;
            return result;
        },
        11 => {
            result = 1048580;
            if ((occupy & 1048576) == 0) result |= 536870912;
            if ((occupy & 537919488) == 0) result |= 274877906944;
            if ((occupy & 275415826432) == 0) result |= 140737488355328;
            return result;
        },
        12 => {
            result = 2097160;
            if ((occupy & 2097152) == 0) result |= 1073741824;
            if ((occupy & 1075838976) == 0) result |= 549755813888;
            return result;
        },
        13 => {
            result = 4194320;
            if ((occupy & 4194304) == 0) result |= 2147483648;
            return result;
        },
        14 => {
            result = 8388640;
            return result;
        },
        15 => {
            result = 64;
            return result;
        },
        16 => {
            result = 33554432;
            if ((occupy & 33554432) == 0) result |= 17179869184;
            if ((occupy & 17213423616) == 0) result |= 8796093022208;
            if ((occupy & 8813306445824) == 0) result |= 4503599627370496;
            if ((occupy & 4512412933816320) == 0) result |= 2305843009213693952;
            return result;
        },
        17 => {
            result = 67109120;
            if ((occupy & 67108864) == 0) result |= 34359738368;
            if ((occupy & 34426847232) == 0) result |= 17592186044416;
            if ((occupy & 17626612891648) == 0) result |= 9007199254740992;
            if ((occupy & 9024825867632640) == 0) result |= 4611686018427387904;
            return result;
        },
        18 => {
            result = 134218240;
            if ((occupy & 512) == 0) result |= 1;
            if ((occupy & 134217728) == 0) result |= 68719476736;
            if ((occupy & 68853694464) == 0) result |= 35184372088832;
            if ((occupy & 35253225783296) == 0) result |= 18014398509481984;
            if ((occupy & 18049651735265280) == 0) result |= 9223372036854775808;
            return result;
        },
        19 => {
            result = 268436480;
            if ((occupy & 1024) == 0) result |= 2;
            if ((occupy & 268435456) == 0) result |= 137438953472;
            if ((occupy & 137707388928) == 0) result |= 70368744177664;
            if ((occupy & 70506451566592) == 0) result |= 36028797018963968;
            return result;
        },
        20 => {
            result = 536872960;
            if ((occupy & 2048) == 0) result |= 4;
            if ((occupy & 536870912) == 0) result |= 274877906944;
            if ((occupy & 275414777856) == 0) result |= 140737488355328;
            return result;
        },
        21 => {
            result = 1073745920;
            if ((occupy & 4096) == 0) result |= 8;
            if ((occupy & 1073741824) == 0) result |= 549755813888;
            return result;
        },
        22 => {
            result = 2147491840;
            if ((occupy & 8192) == 0) result |= 16;
            return result;
        },
        23 => {
            result = 16384;
            if ((occupy & 16384) == 0) result |= 32;
            return result;
        },
        24 => {
            result = 8589934592;
            if ((occupy & 8589934592) == 0) result |= 4398046511104;
            if ((occupy & 4406636445696) == 0) result |= 2251799813685248;
            if ((occupy & 2256206450130944) == 0) result |= 1152921504606846976;
            return result;
        },
        25 => {
            result = 17179934720;
            if ((occupy & 17179869184) == 0) result |= 8796093022208;
            if ((occupy & 8813272891392) == 0) result |= 4503599627370496;
            if ((occupy & 4512412900261888) == 0) result |= 2305843009213693952;
            return result;
        },
        26 => {
            result = 34359869440;
            if ((occupy & 131072) == 0) result |= 256;
            if ((occupy & 34359738368) == 0) result |= 17592186044416;
            if ((occupy & 17626545782784) == 0) result |= 9007199254740992;
            if ((occupy & 9024825800523776) == 0) result |= 4611686018427387904;
            return result;
        },
        27 => {
            result = 68719738880;
            if ((occupy & 262144) == 0) result |= 512;
            if ((occupy & 262656) == 0) result |= 1;
            if ((occupy & 68719476736) == 0) result |= 35184372088832;
            if ((occupy & 35253091565568) == 0) result |= 18014398509481984;
            if ((occupy & 18049651601047552) == 0) result |= 9223372036854775808;
            return result;
        },
        28 => {
            result = 137439477760;
            if ((occupy & 524288) == 0) result |= 1024;
            if ((occupy & 525312) == 0) result |= 2;
            if ((occupy & 137438953472) == 0) result |= 70368744177664;
            if ((occupy & 70506183131136) == 0) result |= 36028797018963968;
            return result;
        },
        29 => {
            result = 274878955520;
            if ((occupy & 1048576) == 0) result |= 2048;
            if ((occupy & 1050624) == 0) result |= 4;
            if ((occupy & 274877906944) == 0) result |= 140737488355328;
            return result;
        },
        30 => {
            result = 549757911040;
            if ((occupy & 2097152) == 0) result |= 4096;
            if ((occupy & 2101248) == 0) result |= 8;
            return result;
        },
        31 => {
            result = 4194304;
            if ((occupy & 4194304) == 0) result |= 8192;
            if ((occupy & 4202496) == 0) result |= 16;
            return result;
        },
        32 => {
            result = 2199023255552;
            if ((occupy & 2199023255552) == 0) result |= 1125899906842624;
            if ((occupy & 1128098930098176) == 0) result |= 576460752303423488;
            return result;
        },
        33 => {
            result = 4398063288320;
            if ((occupy & 4398046511104) == 0) result |= 2251799813685248;
            if ((occupy & 2256197860196352) == 0) result |= 1152921504606846976;
            return result;
        },
        34 => {
            result = 8796126576640;
            if ((occupy & 33554432) == 0) result |= 65536;
            if ((occupy & 8796093022208) == 0) result |= 4503599627370496;
            if ((occupy & 4512395720392704) == 0) result |= 2305843009213693952;
            return result;
        },
        35 => {
            result = 17592253153280;
            if ((occupy & 67108864) == 0) result |= 131072;
            if ((occupy & 67239936) == 0) result |= 256;
            if ((occupy & 17592186044416) == 0) result |= 9007199254740992;
            if ((occupy & 9024791440785408) == 0) result |= 4611686018427387904;
            return result;
        },
        36 => {
            result = 35184506306560;
            if ((occupy & 134217728) == 0) result |= 262144;
            if ((occupy & 134479872) == 0) result |= 512;
            if ((occupy & 134480384) == 0) result |= 1;
            if ((occupy & 35184372088832) == 0) result |= 18014398509481984;
            if ((occupy & 18049582881570816) == 0) result |= 9223372036854775808;
            return result;
        },
        37 => {
            result = 70369012613120;
            if ((occupy & 268435456) == 0) result |= 524288;
            if ((occupy & 268959744) == 0) result |= 1024;
            if ((occupy & 268960768) == 0) result |= 2;
            if ((occupy & 70368744177664) == 0) result |= 36028797018963968;
            return result;
        },
        38 => {
            result = 140738025226240;
            if ((occupy & 536870912) == 0) result |= 1048576;
            if ((occupy & 537919488) == 0) result |= 2048;
            if ((occupy & 537921536) == 0) result |= 4;
            return result;
        },
        39 => {
            result = 1073741824;
            if ((occupy & 1073741824) == 0) result |= 2097152;
            if ((occupy & 1075838976) == 0) result |= 4096;
            if ((occupy & 1075843072) == 0) result |= 8;
            return result;
        },
        40 => {
            result = 562949953421312;
            if ((occupy & 562949953421312) == 0) result |= 288230376151711744;
            return result;
        },
        41 => {
            result = 1125904201809920;
            if ((occupy & 1125899906842624) == 0) result |= 576460752303423488;
            return result;
        },
        42 => {
            result = 2251808403619840;
            if ((occupy & 8589934592) == 0) result |= 16777216;
            if ((occupy & 2251799813685248) == 0) result |= 1152921504606846976;
            return result;
        },
        43 => {
            result = 4503616807239680;
            if ((occupy & 17179869184) == 0) result |= 33554432;
            if ((occupy & 17213423616) == 0) result |= 65536;
            if ((occupy & 4503599627370496) == 0) result |= 2305843009213693952;
            return result;
        },
        44 => {
            result = 9007233614479360;
            if ((occupy & 34359738368) == 0) result |= 67108864;
            if ((occupy & 34426847232) == 0) result |= 131072;
            if ((occupy & 34426978304) == 0) result |= 256;
            if ((occupy & 9007199254740992) == 0) result |= 4611686018427387904;
            return result;
        },
        45 => {
            result = 18014467228958720;
            if ((occupy & 68719476736) == 0) result |= 134217728;
            if ((occupy & 68853694464) == 0) result |= 262144;
            if ((occupy & 68853956608) == 0) result |= 512;
            if ((occupy & 68853957120) == 0) result |= 1;
            if ((occupy & 18014398509481984) == 0) result |= 9223372036854775808;
            return result;
        },
        46 => {
            result = 36028934457917440;
            if ((occupy & 137438953472) == 0) result |= 268435456;
            if ((occupy & 137707388928) == 0) result |= 524288;
            if ((occupy & 137707913216) == 0) result |= 1024;
            if ((occupy & 137707914240) == 0) result |= 2;
            return result;
        },
        47 => {
            result = 274877906944;
            if ((occupy & 274877906944) == 0) result |= 536870912;
            if ((occupy & 275414777856) == 0) result |= 1048576;
            if ((occupy & 275415826432) == 0) result |= 2048;
            if ((occupy & 275415828480) == 0) result |= 4;
            return result;
        },
        48 => {
            result = 144115188075855872;
            return result;
        },
        49 => {
            result = 288231475663339520;
            return result;
        },
        50 => {
            result = 576462951326679040;
            if ((occupy & 2199023255552) == 0) result |= 4294967296;
            return result;
        },
        51 => {
            result = 1152925902653358080;
            if ((occupy & 4398046511104) == 0) result |= 8589934592;
            if ((occupy & 4406636445696) == 0) result |= 16777216;
            return result;
        },
        52 => {
            result = 2305851805306716160;
            if ((occupy & 8796093022208) == 0) result |= 17179869184;
            if ((occupy & 8813272891392) == 0) result |= 33554432;
            if ((occupy & 8813306445824) == 0) result |= 65536;
            return result;
        },
        53 => {
            result = 4611703610613432320;
            if ((occupy & 17592186044416) == 0) result |= 34359738368;
            if ((occupy & 17626545782784) == 0) result |= 67108864;
            if ((occupy & 17626612891648) == 0) result |= 131072;
            if ((occupy & 17626613022720) == 0) result |= 256;
            return result;
        },
        54 => {
            result = 9223407221226864640;
            if ((occupy & 35184372088832) == 0) result |= 68719476736;
            if ((occupy & 35253091565568) == 0) result |= 134217728;
            if ((occupy & 35253225783296) == 0) result |= 262144;
            if ((occupy & 35253226045440) == 0) result |= 512;
            if ((occupy & 35253226045952) == 0) result |= 1;
            return result;
        },
        55 => {
            result = 70368744177664;
            if ((occupy & 70368744177664) == 0) result |= 137438953472;
            if ((occupy & 70506183131136) == 0) result |= 268435456;
            if ((occupy & 70506451566592) == 0) result |= 524288;
            if ((occupy & 70506452090880) == 0) result |= 1024;
            if ((occupy & 70506452091904) == 0) result |= 2;
            return result;
        },
        56 => {
            result = 0;
            return result;
        },
        57 => {
            result = 281474976710656;
            return result;
        },
        58 => {
            result = 562949953421312;
            if ((occupy & 562949953421312) == 0) result |= 1099511627776;
            return result;
        },
        59 => {
            result = 1125899906842624;
            if ((occupy & 1125899906842624) == 0) result |= 2199023255552;
            if ((occupy & 1128098930098176) == 0) result |= 4294967296;
            return result;
        },
        60 => {
            result = 2251799813685248;
            if ((occupy & 2251799813685248) == 0) result |= 4398046511104;
            if ((occupy & 2256197860196352) == 0) result |= 8589934592;
            if ((occupy & 2256206450130944) == 0) result |= 16777216;
            return result;
        },
        61 => {
            result = 4503599627370496;
            if ((occupy & 4503599627370496) == 0) result |= 8796093022208;
            if ((occupy & 4512395720392704) == 0) result |= 17179869184;
            if ((occupy & 4512412900261888) == 0) result |= 33554432;
            if ((occupy & 4512412933816320) == 0) result |= 65536;
            return result;
        },
        62 => {
            result = 9007199254740992;
            if ((occupy & 9007199254740992) == 0) result |= 17592186044416;
            if ((occupy & 9024791440785408) == 0) result |= 34359738368;
            if ((occupy & 9024825800523776) == 0) result |= 67108864;
            if ((occupy & 9024825867632640) == 0) result |= 131072;
            if ((occupy & 9024825867763712) == 0) result |= 256;
            return result;
        },
        63 => {
            result = 18014398509481984;
            if ((occupy & 18014398509481984) == 0) result |= 35184372088832;
            if ((occupy & 18049582881570816) == 0) result |= 68719476736;
            if ((occupy & 18049651601047552) == 0) result |= 134217728;
            if ((occupy & 18049651735265280) == 0) result |= 262144;
            if ((occupy & 18049651735527424) == 0) result |= 512;
            if ((occupy & 18049651735527936) == 0) result |= 1;
            return result;
        },
        else => {
            unreachable;
        },
    }
}

pub const rmask = [_]u64{
    0x000101010101017E, 0x000202020202027C, 0x000404040404047A, 0x0008080808080876, 0x001010101010106E, 0x002020202020205E, 0x004040404040403E, 0x008080808080807E,
    0x0001010101017E00, 0x0002020202027C00, 0x0004040404047A00, 0x0008080808087600, 0x0010101010106E00, 0x0020202020205E00, 0x0040404040403E00, 0x0080808080807E00,
    0x00010101017E0100, 0x00020202027C0200, 0x00040404047A0400, 0x0008080808760800, 0x00101010106E1000, 0x00202020205E2000, 0x00404040403E4000, 0x00808080807E8000,
    0x000101017E010100, 0x000202027C020200, 0x000404047A040400, 0x0008080876080800, 0x001010106E101000, 0x002020205E202000, 0x004040403E404000, 0x008080807E808000,
    0x0001017E01010100, 0x0002027C02020200, 0x0004047A04040400, 0x0008087608080800, 0x0010106E10101000, 0x0020205E20202000, 0x0040403E40404000, 0x0080807E80808000,
    0x00017E0101010100, 0x00027C0202020200, 0x00047A0404040400, 0x0008760808080800, 0x00106E1010101000, 0x00205E2020202000, 0x00403E4040404000, 0x00807E8080808000,
    0x007E010101010100, 0x007C020202020200, 0x007A040404040400, 0x0076080808080800, 0x006E101010101000, 0x005E202020202000, 0x003E404040404000, 0x007E808080808000,
    0x7E01010101010100, 0x7C02020202020200, 0x7A04040404040400, 0x7608080808080800, 0x6E10101010101000, 0x5E20202020202000, 0x3E40404040404000, 0x7E80808080808000,
};
pub const bmask = [_]u64{
    0x0040201008040200, 0x0000402010080400, 0x0000004020100A00, 0x0000000040221400, 0x0000000002442800, 0x0000000204085000, 0x0000020408102000, 0x0002040810204000,
    0x0020100804020000, 0x0040201008040000, 0x00004020100A0000, 0x0000004022140000, 0x0000000244280000, 0x0000020408500000, 0x0002040810200000, 0x0004081020400000,
    0x0010080402000200, 0x0020100804000400, 0x004020100A000A00, 0x0000402214001400, 0x0000024428002800, 0x0002040850005000, 0x0004081020002000, 0x0008102040004000,
    0x0008040200020400, 0x0010080400040800, 0x0020100A000A1000, 0x0040221400142200, 0x0002442800284400, 0x0004085000500800, 0x0008102000201000, 0x0010204000402000,
    0x0004020002040800, 0x0008040004081000, 0x00100A000A102000, 0x0022140014224000, 0x0044280028440200, 0x0008500050080400, 0x0010200020100800, 0x0020400040201000,
    0x0002000204081000, 0x0004000408102000, 0x000A000A10204000, 0x0014001422400000, 0x0028002844020000, 0x0050005008040200, 0x0020002010080400, 0x0040004020100800,
    0x0000020408102000, 0x0000040810204000, 0x00000A1020400000, 0x0000142240000000, 0x0000284402000000, 0x0000500804020000, 0x0000201008040200, 0x0000402010080400,
    0x0002040810204000, 0x0004081020400000, 0x000A102040000000, 0x0014224000000000, 0x0028440200000000, 0x0050080402000000, 0x0020100804020000, 0x0040201008040200,
};
pub const rook_mask = [_]u64{
    0x01010101010101FE, 0x02020202020202FD, 0x04040404040404FB, 0x08080808080808F7, 0x10101010101010EF, 0x20202020202020DF, 0x40404040404040BF, 0x808080808080807F,
    0x010101010101FE01, 0x020202020202FD02, 0x040404040404FB04, 0x080808080808F708, 0x101010101010EF10, 0x202020202020DF20, 0x404040404040BF40, 0x8080808080807F80,
    0x0101010101FE0101, 0x0202020202FD0202, 0x0404040404FB0404, 0x0808080808F70808, 0x1010101010EF1010, 0x2020202020DF2020, 0x4040404040BF4040, 0x80808080807F8080,
    0x01010101FE010101, 0x02020202FD020202, 0x04040404FB040404, 0x08080808F7080808, 0x10101010EF101010, 0x20202020DF202020, 0x40404040BF404040, 0x808080807F808080,
    0x010101FE01010101, 0x020202FD02020202, 0x040404FB04040404, 0x080808F708080808, 0x101010EF10101010, 0x202020DF20202020, 0x404040BF40404040, 0x8080807F80808080,
    0x0101FE0101010101, 0x0202FD0202020202, 0x0404FB0404040404, 0x0808F70808080808, 0x1010EF1010101010, 0x2020DF2020202020, 0x4040BF4040404040, 0x80807F8080808080,
    0x01FE010101010101, 0x02FD020202020202, 0x04FB040404040404, 0x08F7080808080808, 0x10EF101010101010, 0x20DF202020202020, 0x40BF404040404040, 0x807F808080808080,
    0xFE01010101010101, 0xFD02020202020202, 0xFB04040404040404, 0xF708080808080808, 0xEF10101010101010, 0xDF20202020202020, 0xBF40404040404040, 0x7F80808080808080,
};
pub const bishop_mask = [_]u64{
    0x8040201008040200, 0x0080402010080500, 0x0000804020110A00, 0x0000008041221400, 0x0000000182442800, 0x0000010204885000, 0x000102040810A000, 0x0102040810204000,
    0x4020100804020002, 0x8040201008050005, 0x00804020110A000A, 0x0000804122140014, 0x0000018244280028, 0x0001020488500050, 0x0102040810A000A0, 0x0204081020400040,
    0x2010080402000204, 0x4020100805000508, 0x804020110A000A11, 0x0080412214001422, 0x0001824428002844, 0x0102048850005088, 0x02040810A000A010, 0x0408102040004020,
    0x1008040200020408, 0x2010080500050810, 0x4020110A000A1120, 0x8041221400142241, 0x0182442800284482, 0x0204885000508804, 0x040810A000A01008, 0x0810204000402010,
    0x0804020002040810, 0x1008050005081020, 0x20110A000A112040, 0x4122140014224180, 0x8244280028448201, 0x0488500050880402, 0x0810A000A0100804, 0x1020400040201008,
    0x0402000204081020, 0x0805000508102040, 0x110A000A11204080, 0x2214001422418000, 0x4428002844820100, 0x8850005088040201, 0x10A000A010080402, 0x2040004020100804,
    0x0200020408102040, 0x0500050810204080, 0x0A000A1120408000, 0x1400142241800000, 0x2800284482010000, 0x5000508804020100, 0xA000A01008040201, 0x4000402010080402,
    0x0002040810204080, 0x0005081020408000, 0x000A112040800000, 0x0014224180000000, 0x0028448201000000, 0x0050880402010000, 0x00A0100804020100, 0x0040201008040201,
};
pub const king_attacks = [_]u64{
    0x0000000000000302, 0x0000000000000705, 0x0000000000000E0A, 0x0000000000001C14, 0x0000000000003828, 0x0000000000007050, 0x000000000000E0A0, 0x000000000000C040,
    0x0000000000030203, 0x0000000000070507, 0x00000000000E0A0E, 0x00000000001C141C, 0x0000000000382838, 0x0000000000705070, 0x0000000000E0A0E0, 0x0000000000C040C0,
    0x0000000003020300, 0x0000000007050700, 0x000000000E0A0E00, 0x000000001C141C00, 0x0000000038283800, 0x0000000070507000, 0x00000000E0A0E000, 0x00000000C040C000,
    0x0000000302030000, 0x0000000705070000, 0x0000000E0A0E0000, 0x0000001C141C0000, 0x0000003828380000, 0x0000007050700000, 0x000000E0A0E00000, 0x000000C040C00000,
    0x0000030203000000, 0x0000070507000000, 0x00000E0A0E000000, 0x00001C141C000000, 0x0000382838000000, 0x0000705070000000, 0x0000E0A0E0000000, 0x0000C040C0000000,
    0x0003020300000000, 0x0007050700000000, 0x000E0A0E00000000, 0x001C141C00000000, 0x0038283800000000, 0x0070507000000000, 0x00E0A0E000000000, 0x00C040C000000000,
    0x0302030000000000, 0x0705070000000000, 0x0E0A0E0000000000, 0x1C141C0000000000, 0x3828380000000000, 0x7050700000000000, 0xE0A0E00000000000, 0xC040C00000000000,
    0x0203000000000000, 0x0507000000000000, 0x0A0E000000000000, 0x141C000000000000, 0x2838000000000000, 0x5070000000000000, 0xA0E0000000000000, 0x40C0000000000000,
};
pub const knight_attacks = [_]u64{
    0x0000000000020400, 0x0000000000050800, 0x00000000000A1100, 0x0000000000142200, 0x0000000000284400, 0x0000000000508800, 0x0000000000A01000, 0x0000000000402000,
    0x0000000002040004, 0x0000000005080008, 0x000000000A110011, 0x0000000014220022, 0x0000000028440044, 0x0000000050880088, 0x00000000A0100010, 0x0000000040200020,
    0x0000000204000402, 0x0000000508000805, 0x0000000A1100110A, 0x0000001422002214, 0x0000002844004428, 0x0000005088008850, 0x000000A0100010A0, 0x0000004020002040,
    0x0000020400040200, 0x0000050800080500, 0x00000A1100110A00, 0x0000142200221400, 0x0000284400442800, 0x0000508800885000, 0x0000A0100010A000, 0x0000402000204000,
    0x0002040004020000, 0x0005080008050000, 0x000A1100110A0000, 0x0014220022140000, 0x0028440044280000, 0x0050880088500000, 0x00A0100010A00000, 0x0040200020400000,
    0x0204000402000000, 0x0508000805000000, 0x0A1100110A000000, 0x1422002214000000, 0x2844004428000000, 0x5088008850000000, 0xA0100010A0000000, 0x4020002040000000,
    0x0400040200000000, 0x0800080500000000, 0x1100110A00000000, 0x2200221400000000, 0x4400442800000000, 0x8800885000000000, 0x100010A000000000, 0x2000204000000000,
    0x0004020000000000, 0x0008050000000000, 0x00110A0000000000, 0x0022140000000000, 0x0044280000000000, 0x0088500000000000, 0x0010A00000000000, 0x0020400000000000,
};
pub const rook_offset = [64]i32{
    -1406, 12288, 19319, 19984, 1952,  29766, 32259, 7594,
    9509,  45168, 64913, 4097,  61399, 65305, 70898, 28243,
    34322, 28610, 60901, 69887, 68672, 55840, 59430, 24576,
    37413, 65553, 47798, 71937, 72606, 58460, 60534, 30722,
    38672, 74394, 78982, 85768, 51450, 73956, 63248, 40598,
    42494, 74559, 76289, 20516, 77090, 66848, 78434, 44538,
    46513, 25789, 80169, 83641, 53248, 81982, 82750, 16798,
    4066,  52303, 53246, 57208, 4118,  15843, 23373, 12277,
};
pub const bishop_offset = [64]i32{
    12618, 20202, 20163, 508,   8018,  15902, 9185,  20973,
    8404,  11257, -1248, 16111, 9870,  16381, 15588, 18221,
    4052,  8189,  28626, 16597, 11659, 13369, 15676, 16034,
    13424, 18179, 16380, 57088, 15272, -720,  21049, 17185,
    -33,   -896,  15513, 32774, 50610, 27675, 17550, 18179,
    7298,  20044, 12319, 16903, 35172, 23329, 2019,  13555,
    -47,   15752, 18972, 19275, 15610, 13574, -8,    21756,
    21281, 20029, 19844, 24738, 20340, 21015, 20769, 14483,
};
pub const rook_xray_offset = [64]i32{
    87801,  105780, 111874, 118022, 122117, 126231, 130330, 95993,
    136511, 169483, 170492, 157506, 175644, 176380, 177788, 124333,
    132394, 164474, 167419, 174608, 172540, 162362, 100093, 121158,
    134700, 171516, 102194, 176668, 180998, 165370, 165642, 129302,
    138675, 180828, 187677, 194918, 161658, 178814, 169475, 140607,
    142709, 183038, 183495, 184059, 185021, 171649, 186168, 144816,
    148020, 188189, 189486, 190246, 191266, 193310, 194398, 148920,
    91896,  153090, 157310, 161406, 103730, 110110, 116098, 100090,
};
pub const bishop_xray_offset = [64]i32{
    106749, 111924, 113134, 87107,  87465,  87535,  87703,  107548,
    87982,  102838, 105274, 107870, 108590, 107878, 107554, 110392,
    106036, 107768, 100055, 87667,  86579,  92938,  109749, 109454,
    108194, 111648, 96042,  115682, 106202, 96258,  112228, 109624,
    103442, 108333, 107778, 108294, 91899,  103795, 109470, 110302,
    113101, 113246, 94970,  100092, 103288, 91902,  87694,  109376,
    108008, 108596, 108568, 108830, 108751, 86985,  106754, 114370,
    109576, 109976, 112214, 112090, 114156, 112516, 112204, 107006,
};
pub const rook_offset_pext = [64]i32{
    0,     4160,  6240,  8320,  10400, 12480, 14560,  16640,
    20800, 22880, 23936, 24992, 26048, 27104, 28160,  29216,
    31296, 33376, 34432, 35584, 36736, 37888, 39040,  40096,
    42176, 44256, 45312, 46464, 48000, 49536, 50688,  51744,
    53824, 55904, 56960, 58112, 59648, 61184, 62336,  63392,
    65472, 67552, 68608, 69760, 70912, 72064, 73216,  74272,
    76352, 78432, 79488, 80544, 81600, 82656, 83712,  84768,
    86848, 91008, 93088, 95168, 97248, 99328, 101408, 103488,
};
pub const bishop_offset_pext = [64]i32{
    4096,  6208,  8288,  10368, 12448, 14528,  16608,  20736,
    22848, 23904, 24960, 26016, 27072, 28128,  29184,  31264,
    33344, 34400, 35456, 36608, 37760, 38912,  40064,  42144,
    44224, 45280, 46336, 47488, 49024, 50560,  51712,  53792,
    55872, 56928, 57984, 59136, 60672, 62208,  63360,  65440,
    67520, 68576, 69632, 70784, 71936, 73088,  74240,  76320,
    78400, 79456, 80512, 81568, 82624, 83680,  84736,  86816,
    90944, 93056, 95136, 97216, 99296, 101376, 103456, 107584,
};
pub const rook_xray_offset_pext = [64]i32{
    107648, 111808, 113888, 115968, 118048, 120128, 122208, 124288,
    128448, 130528, 131584, 132640, 133696, 134752, 135808, 136864,
    138944, 141024, 142080, 143232, 144384, 145536, 146688, 147744,
    149824, 151904, 152960, 154112, 155648, 157184, 158336, 159392,
    161472, 163552, 164608, 165760, 167296, 168832, 169984, 171040,
    173120, 175200, 176256, 177408, 178560, 179712, 180864, 181920,
    184000, 186080, 187136, 188192, 189248, 190304, 191360, 192416,
    194496, 198656, 200736, 202816, 204896, 206976, 209056, 211136,
};
pub const bishop_xray_offset_pext = [64]i32{
    111744, 113856, 115936, 118016, 120096, 122176, 124256, 128384,
    130496, 131552, 132608, 133664, 134720, 135776, 136832, 138912,
    140992, 142048, 143104, 144256, 145408, 146560, 147712, 149792,
    151872, 152928, 153984, 155136, 156672, 158208, 159360, 161440,
    163520, 164576, 165632, 166784, 168320, 169856, 171008, 173088,
    175168, 176224, 177280, 178432, 179584, 180736, 181888, 183968,
    186048, 187104, 188160, 189216, 190272, 191328, 192384, 194464,
    198592, 200704, 202784, 204864, 206944, 209024, 211104, 215232,
};
pub const rook_seed = [64]u64{
    0x0050020428000230, 0x23000C80400004A0, 0x8030010086000090, 0x0028002022A00028, 0x8050028010500041, 0x8030018800C80030, 0x00300060003000C0, 0x8050040850000960,
    0x580028010114000A, 0x10000C0086000300, 0x1800080402010008, 0x0C120002848A0001, 0x0080300180009021, 0x00801800C0180060, 0x1580680068080011, 0x8300180030640018,
    0x00300018010C0003, 0x0706000C00830004, 0x1941000804020008, 0x5004002002002004, 0x640E004002004004, 0x220A001000410010, 0x8288004001000080, 0x00001200003C0009,
    0x4140200010080010, 0x8010040008020008, 0x1042010008040008, 0x9020020020040021, 0x0040010020020020, 0x00C0008020092020, 0x4260400040008001, 0x202FC00040000080,
    0x0800091800300030, 0x3004000800100011, 0x0200400880410010, 0x80E0200400200200, 0xB480200100200200, 0x94A0200080200100, 0x3000200480200040, 0x0054802000200040,
    0x0400020A14002800, 0x0300030086000C00, 0x2400400840804200, 0x0300002049801800, 0x2010009001803003, 0x1200004001004002, 0x442000100800A804, 0x5108000D90005802,
    0x000100022C008058, 0x4C00068880110020, 0x1080030040488018, 0xA980200200040020, 0x20104000310D8040, 0x0440500010208050, 0x0440000810580050, 0x2107000002280028,
    0x080004802010411A, 0x3300010180086C41, 0x08200000C05D0501, 0x08904000081003E2, 0x020200004501428A, 0xA000000403700802, 0x040C000448008402, 0x2042000829028842,
};
pub const bishop_seed = [64]u64{
    0x1C10004100408005, 0x000060C012000C04, 0x0000304829001002, 0x80005014028802C0, 0x10003C0503004801, 0x4006008008000011, 0x4010054040014100, 0x0000201002010040,
    0x100501002A900008, 0x2300180200C00805, 0x101000A0A0140281, 0x2508A00210010C10, 0x800C003C01400814, 0x000188007C002000, 0x4500041008010010, 0x000000210240C048,
    0x0020001004010040, 0x0140080020202002, 0x0000088010102008, 0x4000085080200448, 0x8020200180500029, 0x04500200400802C0, 0x0A04880100020100, 0x2002401040020080,
    0x0088000D0701C080, 0x0243001801818018, 0x8080008980100400, 0x00420020280007A0, 0x0201C00820041001, 0x4100A02800410500, 0x0400802000802010, 0x00081800C4084042,
    0x0100008017008028, 0x2400002843402014, 0x00100200100200A4, 0x0060004010010010, 0x6000802002008008, 0x0341829024000608, 0x0320601803001094, 0x0600483001803018,
    0x2220004051230010, 0x0000001480410008, 0x0220A02010002800, 0x000C800840300018, 0x40810300C00C0012, 0x0248040080020020, 0x0110020080200100, 0x4000104003081401,
    0x00000020150080A4, 0x0A00200020800908, 0xE44B04000C001020, 0x000A080000800EC1, 0x0003200020000BE0, 0x0420001280100400, 0x0000008080280560, 0x20000100400400B0,
    0x9010000C000B0013, 0x020880020005800C, 0x0061002010410028, 0x6004100090080060, 0x000803000045000C, 0x4808000141020014, 0x024C004041004001, 0x8100401840102001,
};
pub const rook_xray_seed = [64]u64{
    0x9208029202000400, 0x00200010000800A4, 0x0040100040080004, 0x0040080102400400, 0x0040040040020001, 0x0020008020010202, 0x0040010000800040, 0x12000185C106001C,
    0x0100081020410400, 0x4100100008040010, 0x0000080402010008, 0x4088800410800208, 0x8200200200010020, 0x3000200100008020, 0x0800202000800040, 0x0A00200020004081,
    0x0140002000100028, 0x4804001000080010, 0x4001000804020008, 0x0144002002002004, 0x0002001001008010, 0x0401002000802001, 0x0140040002A52810, 0x8441802000400020,
    0x1140200010080011, 0x8010040008020009, 0x00000400100200F0, 0x0200040020200200, 0x50A0010020020020, 0x4000008020010020, 0x1100008020200040, 0x8003800020004020,
    0x0840001000200024, 0x0600080400100010, 0x2000400880410010, 0x2480200200200400, 0x4802008040080008, 0x0820200080200100, 0x8080200080200040, 0x4109802000200040,
    0x0440201004000806, 0x5010080102000400, 0x2100084040804201, 0x0440020004002020, 0x0060020001002020, 0x0850010000802020, 0x0810400080004001, 0x0000420088004204,
    0x4840001000200020, 0x0004001000080010, 0x1100080401020008, 0x0080040020020020, 0x0040010020020020, 0x4008200100008020, 0x4400200040008020, 0x4081802000400020,
    0x0080000D01183A91, 0x4000801165000841, 0x8041000822400411, 0x0840100420400802, 0x000C20003C100802, 0xB00C002310080402, 0x3A00033800804402, 0x0A800010E404894A,
};
pub const bishop_xray_seed = [64]u64{
    0x0000440020404001, 0x00004010041C0149, 0x4000091040040003, 0x1012082008140000, 0x0069041004010200, 0x00C4820803000108, 0x0022410410400000, 0x0040021040020020,
    0x4020A41040400104, 0x000C004040080020, 0x8086001010006800, 0x0D08410004011010, 0x0008400400200001, 0x1482000101004200, 0x0120021040020020, 0xAA08880210008010,
    0x0800240040404001, 0x0000041100101002, 0xC412003000802B00, 0x1028202904001000, 0x0402080100820005, 0x0100100080040101, 0x40D8021080008020, 0x0008021120004008,
    0x2040048002002008, 0x8080800400202004, 0x0300020004002008, 0x0000608000088010, 0x0200200800030100, 0x9084001010200400, 0x0000080080202009, 0x0A08080200002004,
    0x1000058009008020, 0x8100030010004011, 0x6080008020004006, 0x0080004010010030, 0x8820010040040040, 0x0420008020010004, 0x0009000802202001, 0x2C00100400401002,
    0x4000400200200010, 0x4200008080104029, 0x0000080100808400, 0x20C1406005000800, 0x0820010020032008, 0x00400300C0800900, 0x0000810040090104, 0x0280080008004002,
    0x1608004010802002, 0x4300004008410004, 0x0208801000800C00, 0x0200000000401000, 0x0118020680200208, 0x0000010040024100, 0x0088020080100400, 0x8001001020080060,
    0x8000004008410020, 0x0C08000020084010, 0x1000030410088008, 0x0240808800004010, 0x8000800000802002, 0x1C00860140601001, 0x006F020000401002, 0x1008020080100401,
};

pub const SliderPextT = struct {
    attack_ptr: usize,
    mask: u64,

    pub fn init(offset: usize, mask: u64) @This() {
        return .{
            .attack_ptr = offset,
            .mask = mask,
        };
    }

    fn pextU64Emulated(val: u64, mask: u64) u64 {
        var res: u64 = 0;
        var bb: u64 = 1;
        var m = mask;
        while (m != 0) : (bb += bb) {
            if ((val & m & (0 -% m)) != 0) {
                res |= bb;
            }
            m &= (m - 1);
        }
        return res;
    }

    pub inline fn get(self: @This(), blocker: u64) u64 {
        return ChessLookup.slider_pext[self.attack_ptr + pextU64Emulated(blocker, self.mask)];
    }
};

pub const SliderHashT = struct {
    attack_ptr: usize,
    seed: u64,
    mask: u64,

    pub inline fn init(offset: usize, seed: u64, mask: u64) @This() {
        return .{
            .attack_ptr = offset,
            .seed = seed,
            .mask = mask,
        };
    }

    pub inline fn get(self: @This(), blocker: u64) u64 {
        return ChessLookup.slider_hash[self.attack_ptr + ((self.mask | blocker) * self.seed) >> (64 - 12)];
    }
};

pub const hash_rook_attacks = [64]SliderHashT{
    SliderHashT.init(rook_offset[0], rook_seed[0], ~rmask[0]),
    SliderHashT.init(rook_offset[1], rook_seed[1], ~rmask[1]),
    SliderHashT.init(rook_offset[2], rook_seed[2], ~rmask[2]),
    SliderHashT.init(rook_offset[3], rook_seed[3], ~rmask[3]),
    SliderHashT.init(rook_offset[4], rook_seed[4], ~rmask[4]),
    SliderHashT.init(rook_offset[5], rook_seed[5], ~rmask[5]),
    SliderHashT.init(rook_offset[6], rook_seed[6], ~rmask[6]),
    SliderHashT.init(rook_offset[7], rook_seed[7], ~rmask[7]),
    SliderHashT.init(rook_offset[8], rook_seed[8], ~rmask[8]),
    SliderHashT.init(rook_offset[9], rook_seed[9], ~rmask[9]),
    SliderHashT.init(rook_offset[10], rook_seed[10], ~rmask[10]),
    SliderHashT.init(rook_offset[11], rook_seed[11], ~rmask[11]),
    SliderHashT.init(rook_offset[12], rook_seed[12], ~rmask[12]),
    SliderHashT.init(rook_offset[13], rook_seed[13], ~rmask[13]),
    SliderHashT.init(rook_offset[14], rook_seed[14], ~rmask[14]),
    SliderHashT.init(rook_offset[15], rook_seed[15], ~rmask[15]),
    SliderHashT.init(rook_offset[16], rook_seed[16], ~rmask[16]),
    SliderHashT.init(rook_offset[17], rook_seed[17], ~rmask[17]),
    SliderHashT.init(rook_offset[18], rook_seed[18], ~rmask[18]),
    SliderHashT.init(rook_offset[19], rook_seed[19], ~rmask[19]),
    SliderHashT.init(rook_offset[20], rook_seed[20], ~rmask[20]),
    SliderHashT.init(rook_offset[21], rook_seed[21], ~rmask[21]),
    SliderHashT.init(rook_offset[22], rook_seed[22], ~rmask[22]),
    SliderHashT.init(rook_offset[23], rook_seed[23], ~rmask[23]),
    SliderHashT.init(rook_offset[24], rook_seed[24], ~rmask[24]),
    SliderHashT.init(rook_offset[25], rook_seed[25], ~rmask[25]),
    SliderHashT.init(rook_offset[26], rook_seed[26], ~rmask[26]),
    SliderHashT.init(rook_offset[27], rook_seed[27], ~rmask[27]),
    SliderHashT.init(rook_offset[28], rook_seed[28], ~rmask[28]),
    SliderHashT.init(rook_offset[29], rook_seed[29], ~rmask[29]),
    SliderHashT.init(rook_offset[30], rook_seed[30], ~rmask[30]),
    SliderHashT.init(rook_offset[31], rook_seed[31], ~rmask[31]),
    SliderHashT.init(rook_offset[32], rook_seed[32], ~rmask[32]),
    SliderHashT.init(rook_offset[33], rook_seed[33], ~rmask[33]),
    SliderHashT.init(rook_offset[34], rook_seed[34], ~rmask[34]),
    SliderHashT.init(rook_offset[35], rook_seed[35], ~rmask[35]),
    SliderHashT.init(rook_offset[36], rook_seed[36], ~rmask[36]),
    SliderHashT.init(rook_offset[37], rook_seed[37], ~rmask[37]),
    SliderHashT.init(rook_offset[38], rook_seed[38], ~rmask[38]),
    SliderHashT.init(rook_offset[39], rook_seed[39], ~rmask[39]),
    SliderHashT.init(rook_offset[40], rook_seed[40], ~rmask[40]),
    SliderHashT.init(rook_offset[41], rook_seed[41], ~rmask[41]),
    SliderHashT.init(rook_offset[42], rook_seed[42], ~rmask[42]),
    SliderHashT.init(rook_offset[43], rook_seed[43], ~rmask[43]),
    SliderHashT.init(rook_offset[44], rook_seed[44], ~rmask[44]),
    SliderHashT.init(rook_offset[45], rook_seed[45], ~rmask[45]),
    SliderHashT.init(rook_offset[46], rook_seed[46], ~rmask[46]),
    SliderHashT.init(rook_offset[47], rook_seed[47], ~rmask[47]),
    SliderHashT.init(rook_offset[48], rook_seed[48], ~rmask[48]),
    SliderHashT.init(rook_offset[49], rook_seed[49], ~rmask[49]),
    SliderHashT.init(rook_offset[50], rook_seed[50], ~rmask[50]),
    SliderHashT.init(rook_offset[51], rook_seed[51], ~rmask[51]),
    SliderHashT.init(rook_offset[52], rook_seed[52], ~rmask[52]),
    SliderHashT.init(rook_offset[53], rook_seed[53], ~rmask[53]),
    SliderHashT.init(rook_offset[54], rook_seed[54], ~rmask[54]),
    SliderHashT.init(rook_offset[55], rook_seed[55], ~rmask[55]),
    SliderHashT.init(rook_offset[56], rook_seed[56], ~rmask[56]),
    SliderHashT.init(rook_offset[57], rook_seed[57], ~rmask[57]),
    SliderHashT.init(rook_offset[58], rook_seed[58], ~rmask[58]),
    SliderHashT.init(rook_offset[59], rook_seed[59], ~rmask[59]),
    SliderHashT.init(rook_offset[60], rook_seed[60], ~rmask[60]),
    SliderHashT.init(rook_offset[61], rook_seed[61], ~rmask[61]),
    SliderHashT.init(rook_offset[62], rook_seed[62], ~rmask[62]),
    SliderHashT.init(rook_offset[63], rook_seed[63], ~rmask[63]),
};
pub const hash_bishop_attacks = [64]SliderHashT{
    SliderHashT.init(bishop_offset[0], bishop_seed[0], ~bmask[0]),
    SliderHashT.init(bishop_offset[1], bishop_seed[1], ~bmask[1]),
    SliderHashT.init(bishop_offset[2], bishop_seed[2], ~bmask[2]),
    SliderHashT.init(bishop_offset[3], bishop_seed[3], ~bmask[3]),
    SliderHashT.init(bishop_offset[4], bishop_seed[4], ~bmask[4]),
    SliderHashT.init(bishop_offset[5], bishop_seed[5], ~bmask[5]),
    SliderHashT.init(bishop_offset[6], bishop_seed[6], ~bmask[6]),
    SliderHashT.init(bishop_offset[7], bishop_seed[7], ~bmask[7]),
    SliderHashT.init(bishop_offset[8], bishop_seed[8], ~bmask[8]),
    SliderHashT.init(bishop_offset[9], bishop_seed[9], ~bmask[9]),
    SliderHashT.init(bishop_offset[10], bishop_seed[10], ~bmask[10]),
    SliderHashT.init(bishop_offset[11], bishop_seed[11], ~bmask[11]),
    SliderHashT.init(bishop_offset[12], bishop_seed[12], ~bmask[12]),
    SliderHashT.init(bishop_offset[13], bishop_seed[13], ~bmask[13]),
    SliderHashT.init(bishop_offset[14], bishop_seed[14], ~bmask[14]),
    SliderHashT.init(bishop_offset[15], bishop_seed[15], ~bmask[15]),
    SliderHashT.init(bishop_offset[16], bishop_seed[16], ~bmask[16]),
    SliderHashT.init(bishop_offset[17], bishop_seed[17], ~bmask[17]),
    SliderHashT.init(bishop_offset[18], bishop_seed[18], ~bmask[18]),
    SliderHashT.init(bishop_offset[19], bishop_seed[19], ~bmask[19]),
    SliderHashT.init(bishop_offset[20], bishop_seed[20], ~bmask[20]),
    SliderHashT.init(bishop_offset[21], bishop_seed[21], ~bmask[21]),
    SliderHashT.init(bishop_offset[22], bishop_seed[22], ~bmask[22]),
    SliderHashT.init(bishop_offset[23], bishop_seed[23], ~bmask[23]),
    SliderHashT.init(bishop_offset[24], bishop_seed[24], ~bmask[24]),
    SliderHashT.init(bishop_offset[25], bishop_seed[25], ~bmask[25]),
    SliderHashT.init(bishop_offset[26], bishop_seed[26], ~bmask[26]),
    SliderHashT.init(bishop_offset[27], bishop_seed[27], ~bmask[27]),
    SliderHashT.init(bishop_offset[28], bishop_seed[28], ~bmask[28]),
    SliderHashT.init(bishop_offset[29], bishop_seed[29], ~bmask[29]),
    SliderHashT.init(bishop_offset[30], bishop_seed[30], ~bmask[30]),
    SliderHashT.init(bishop_offset[31], bishop_seed[31], ~bmask[31]),
    SliderHashT.init(bishop_offset[32], bishop_seed[32], ~bmask[32]),
    SliderHashT.init(bishop_offset[33], bishop_seed[33], ~bmask[33]),
    SliderHashT.init(bishop_offset[34], bishop_seed[34], ~bmask[34]),
    SliderHashT.init(bishop_offset[35], bishop_seed[35], ~bmask[35]),
    SliderHashT.init(bishop_offset[36], bishop_seed[36], ~bmask[36]),
    SliderHashT.init(bishop_offset[37], bishop_seed[37], ~bmask[37]),
    SliderHashT.init(bishop_offset[38], bishop_seed[38], ~bmask[38]),
    SliderHashT.init(bishop_offset[39], bishop_seed[39], ~bmask[39]),
    SliderHashT.init(bishop_offset[40], bishop_seed[40], ~bmask[40]),
    SliderHashT.init(bishop_offset[41], bishop_seed[41], ~bmask[41]),
    SliderHashT.init(bishop_offset[42], bishop_seed[42], ~bmask[42]),
    SliderHashT.init(bishop_offset[43], bishop_seed[43], ~bmask[43]),
    SliderHashT.init(bishop_offset[44], bishop_seed[44], ~bmask[44]),
    SliderHashT.init(bishop_offset[45], bishop_seed[45], ~bmask[45]),
    SliderHashT.init(bishop_offset[46], bishop_seed[46], ~bmask[46]),
    SliderHashT.init(bishop_offset[47], bishop_seed[47], ~bmask[47]),
    SliderHashT.init(bishop_offset[48], bishop_seed[48], ~bmask[48]),
    SliderHashT.init(bishop_offset[49], bishop_seed[49], ~bmask[49]),
    SliderHashT.init(bishop_offset[50], bishop_seed[50], ~bmask[50]),
    SliderHashT.init(bishop_offset[51], bishop_seed[51], ~bmask[51]),
    SliderHashT.init(bishop_offset[52], bishop_seed[52], ~bmask[52]),
    SliderHashT.init(bishop_offset[53], bishop_seed[53], ~bmask[53]),
    SliderHashT.init(bishop_offset[54], bishop_seed[54], ~bmask[54]),
    SliderHashT.init(bishop_offset[55], bishop_seed[55], ~bmask[55]),
    SliderHashT.init(bishop_offset[56], bishop_seed[56], ~bmask[56]),
    SliderHashT.init(bishop_offset[57], bishop_seed[57], ~bmask[57]),
    SliderHashT.init(bishop_offset[58], bishop_seed[58], ~bmask[58]),
    SliderHashT.init(bishop_offset[59], bishop_seed[59], ~bmask[59]),
    SliderHashT.init(bishop_offset[60], bishop_seed[60], ~bmask[60]),
    SliderHashT.init(bishop_offset[61], bishop_seed[61], ~bmask[61]),
    SliderHashT.init(bishop_offset[62], bishop_seed[62], ~bmask[62]),
    SliderHashT.init(bishop_offset[63], bishop_seed[63], ~bmask[63]),
};
pub const hash_rook_attacks_xray = [64]SliderHashT{
    SliderHashT.init(rook_xray_offset[0], rook_xray_seed[0], ~rmask[0]),
    SliderHashT.init(rook_xray_offset[1], rook_xray_seed[1], ~rmask[1]),
    SliderHashT.init(rook_xray_offset[2], rook_xray_seed[2], ~rmask[2]),
    SliderHashT.init(rook_xray_offset[3], rook_xray_seed[3], ~rmask[3]),
    SliderHashT.init(rook_xray_offset[4], rook_xray_seed[4], ~rmask[4]),
    SliderHashT.init(rook_xray_offset[5], rook_xray_seed[5], ~rmask[5]),
    SliderHashT.init(rook_xray_offset[6], rook_xray_seed[6], ~rmask[6]),
    SliderHashT.init(rook_xray_offset[7], rook_xray_seed[7], ~rmask[7]),
    SliderHashT.init(rook_xray_offset[8], rook_xray_seed[8], ~rmask[8]),
    SliderHashT.init(rook_xray_offset[9], rook_xray_seed[9], ~rmask[9]),
    SliderHashT.init(rook_xray_offset[10], rook_xray_seed[10], ~rmask[10]),
    SliderHashT.init(rook_xray_offset[11], rook_xray_seed[11], ~rmask[11]),
    SliderHashT.init(rook_xray_offset[12], rook_xray_seed[12], ~rmask[12]),
    SliderHashT.init(rook_xray_offset[13], rook_xray_seed[13], ~rmask[13]),
    SliderHashT.init(rook_xray_offset[14], rook_xray_seed[14], ~rmask[14]),
    SliderHashT.init(rook_xray_offset[15], rook_xray_seed[15], ~rmask[15]),
    SliderHashT.init(rook_xray_offset[16], rook_xray_seed[16], ~rmask[16]),
    SliderHashT.init(rook_xray_offset[17], rook_xray_seed[17], ~rmask[17]),
    SliderHashT.init(rook_xray_offset[18], rook_xray_seed[18], ~rmask[18]),
    SliderHashT.init(rook_xray_offset[19], rook_xray_seed[19], ~rmask[19]),
    SliderHashT.init(rook_xray_offset[20], rook_xray_seed[20], ~rmask[20]),
    SliderHashT.init(rook_xray_offset[21], rook_xray_seed[21], ~rmask[21]),
    SliderHashT.init(rook_xray_offset[22], rook_xray_seed[22], ~rmask[22]),
    SliderHashT.init(rook_xray_offset[23], rook_xray_seed[23], ~rmask[23]),
    SliderHashT.init(rook_xray_offset[24], rook_xray_seed[24], ~rmask[24]),
    SliderHashT.init(rook_xray_offset[25], rook_xray_seed[25], ~rmask[25]),
    SliderHashT.init(rook_xray_offset[26], rook_xray_seed[26], ~rmask[26]),
    SliderHashT.init(rook_xray_offset[27], rook_xray_seed[27], ~rmask[27]),
    SliderHashT.init(rook_xray_offset[28], rook_xray_seed[28], ~rmask[28]),
    SliderHashT.init(rook_xray_offset[29], rook_xray_seed[29], ~rmask[29]),
    SliderHashT.init(rook_xray_offset[30], rook_xray_seed[30], ~rmask[30]),
    SliderHashT.init(rook_xray_offset[31], rook_xray_seed[31], ~rmask[31]),
    SliderHashT.init(rook_xray_offset[32], rook_xray_seed[32], ~rmask[32]),
    SliderHashT.init(rook_xray_offset[33], rook_xray_seed[33], ~rmask[33]),
    SliderHashT.init(rook_xray_offset[34], rook_xray_seed[34], ~rmask[34]),
    SliderHashT.init(rook_xray_offset[35], rook_xray_seed[35], ~rmask[35]),
    SliderHashT.init(rook_xray_offset[36], rook_xray_seed[36], ~rmask[36]),
    SliderHashT.init(rook_xray_offset[37], rook_xray_seed[37], ~rmask[37]),
    SliderHashT.init(rook_xray_offset[38], rook_xray_seed[38], ~rmask[38]),
    SliderHashT.init(rook_xray_offset[39], rook_xray_seed[39], ~rmask[39]),
    SliderHashT.init(rook_xray_offset[40], rook_xray_seed[40], ~rmask[40]),
    SliderHashT.init(rook_xray_offset[41], rook_xray_seed[41], ~rmask[41]),
    SliderHashT.init(rook_xray_offset[42], rook_xray_seed[42], ~rmask[42]),
    SliderHashT.init(rook_xray_offset[43], rook_xray_seed[43], ~rmask[43]),
    SliderHashT.init(rook_xray_offset[44], rook_xray_seed[44], ~rmask[44]),
    SliderHashT.init(rook_xray_offset[45], rook_xray_seed[45], ~rmask[45]),
    SliderHashT.init(rook_xray_offset[46], rook_xray_seed[46], ~rmask[46]),
    SliderHashT.init(rook_xray_offset[47], rook_xray_seed[47], ~rmask[47]),
    SliderHashT.init(rook_xray_offset[48], rook_xray_seed[48], ~rmask[48]),
    SliderHashT.init(rook_xray_offset[49], rook_xray_seed[49], ~rmask[49]),
    SliderHashT.init(rook_xray_offset[50], rook_xray_seed[50], ~rmask[50]),
    SliderHashT.init(rook_xray_offset[51], rook_xray_seed[51], ~rmask[51]),
    SliderHashT.init(rook_xray_offset[52], rook_xray_seed[52], ~rmask[52]),
    SliderHashT.init(rook_xray_offset[53], rook_xray_seed[53], ~rmask[53]),
    SliderHashT.init(rook_xray_offset[54], rook_xray_seed[54], ~rmask[54]),
    SliderHashT.init(rook_xray_offset[55], rook_xray_seed[55], ~rmask[55]),
    SliderHashT.init(rook_xray_offset[56], rook_xray_seed[56], ~rmask[56]),
    SliderHashT.init(rook_xray_offset[57], rook_xray_seed[57], ~rmask[57]),
    SliderHashT.init(rook_xray_offset[58], rook_xray_seed[58], ~rmask[58]),
    SliderHashT.init(rook_xray_offset[59], rook_xray_seed[59], ~rmask[59]),
    SliderHashT.init(rook_xray_offset[60], rook_xray_seed[60], ~rmask[60]),
    SliderHashT.init(rook_xray_offset[61], rook_xray_seed[61], ~rmask[61]),
    SliderHashT.init(rook_xray_offset[62], rook_xray_seed[62], ~rmask[62]),
    SliderHashT.init(rook_xray_offset[63], rook_xray_seed[63], ~rmask[63]),
};
pub const hash_bishop_attacks_xray = [64]SliderHashT{
    SliderHashT.init(bishop_xray_offset[0], bishop_xray_seed[0], ~bmask[0]),
    SliderHashT.init(bishop_xray_offset[1], bishop_xray_seed[1], ~bmask[1]),
    SliderHashT.init(bishop_xray_offset[2], bishop_xray_seed[2], ~bmask[2]),
    SliderHashT.init(bishop_xray_offset[3], bishop_xray_seed[3], ~bmask[3]),
    SliderHashT.init(bishop_xray_offset[4], bishop_xray_seed[4], ~bmask[4]),
    SliderHashT.init(bishop_xray_offset[5], bishop_xray_seed[5], ~bmask[5]),
    SliderHashT.init(bishop_xray_offset[6], bishop_xray_seed[6], ~bmask[6]),
    SliderHashT.init(bishop_xray_offset[7], bishop_xray_seed[7], ~bmask[7]),
    SliderHashT.init(bishop_xray_offset[8], bishop_xray_seed[8], ~bmask[8]),
    SliderHashT.init(bishop_xray_offset[9], bishop_xray_seed[9], ~bmask[9]),
    SliderHashT.init(bishop_xray_offset[10], bishop_xray_seed[10], ~bmask[10]),
    SliderHashT.init(bishop_xray_offset[11], bishop_xray_seed[11], ~bmask[11]),
    SliderHashT.init(bishop_xray_offset[12], bishop_xray_seed[12], ~bmask[12]),
    SliderHashT.init(bishop_xray_offset[13], bishop_xray_seed[13], ~bmask[13]),
    SliderHashT.init(bishop_xray_offset[14], bishop_xray_seed[14], ~bmask[14]),
    SliderHashT.init(bishop_xray_offset[15], bishop_xray_seed[15], ~bmask[15]),
    SliderHashT.init(bishop_xray_offset[16], bishop_xray_seed[16], ~bmask[16]),
    SliderHashT.init(bishop_xray_offset[17], bishop_xray_seed[17], ~bmask[17]),
    SliderHashT.init(bishop_xray_offset[18], bishop_xray_seed[18], ~bmask[18]),
    SliderHashT.init(bishop_xray_offset[19], bishop_xray_seed[19], ~bmask[19]),
    SliderHashT.init(bishop_xray_offset[20], bishop_xray_seed[20], ~bmask[20]),
    SliderHashT.init(bishop_xray_offset[21], bishop_xray_seed[21], ~bmask[21]),
    SliderHashT.init(bishop_xray_offset[22], bishop_xray_seed[22], ~bmask[22]),
    SliderHashT.init(bishop_xray_offset[23], bishop_xray_seed[23], ~bmask[23]),
    SliderHashT.init(bishop_xray_offset[24], bishop_xray_seed[24], ~bmask[24]),
    SliderHashT.init(bishop_xray_offset[25], bishop_xray_seed[25], ~bmask[25]),
    SliderHashT.init(bishop_xray_offset[26], bishop_xray_seed[26], ~bmask[26]),
    SliderHashT.init(bishop_xray_offset[27], bishop_xray_seed[27], ~bmask[27]),
    SliderHashT.init(bishop_xray_offset[28], bishop_xray_seed[28], ~bmask[28]),
    SliderHashT.init(bishop_xray_offset[29], bishop_xray_seed[29], ~bmask[29]),
    SliderHashT.init(bishop_xray_offset[30], bishop_xray_seed[30], ~bmask[30]),
    SliderHashT.init(bishop_xray_offset[31], bishop_xray_seed[31], ~bmask[31]),
    SliderHashT.init(bishop_xray_offset[32], bishop_xray_seed[32], ~bmask[32]),
    SliderHashT.init(bishop_xray_offset[33], bishop_xray_seed[33], ~bmask[33]),
    SliderHashT.init(bishop_xray_offset[34], bishop_xray_seed[34], ~bmask[34]),
    SliderHashT.init(bishop_xray_offset[35], bishop_xray_seed[35], ~bmask[35]),
    SliderHashT.init(bishop_xray_offset[36], bishop_xray_seed[36], ~bmask[36]),
    SliderHashT.init(bishop_xray_offset[37], bishop_xray_seed[37], ~bmask[37]),
    SliderHashT.init(bishop_xray_offset[38], bishop_xray_seed[38], ~bmask[38]),
    SliderHashT.init(bishop_xray_offset[39], bishop_xray_seed[39], ~bmask[39]),
    SliderHashT.init(bishop_xray_offset[40], bishop_xray_seed[40], ~bmask[40]),
    SliderHashT.init(bishop_xray_offset[41], bishop_xray_seed[41], ~bmask[41]),
    SliderHashT.init(bishop_xray_offset[42], bishop_xray_seed[42], ~bmask[42]),
    SliderHashT.init(bishop_xray_offset[43], bishop_xray_seed[43], ~bmask[43]),
    SliderHashT.init(bishop_xray_offset[44], bishop_xray_seed[44], ~bmask[44]),
    SliderHashT.init(bishop_xray_offset[45], bishop_xray_seed[45], ~bmask[45]),
    SliderHashT.init(bishop_xray_offset[46], bishop_xray_seed[46], ~bmask[46]),
    SliderHashT.init(bishop_xray_offset[47], bishop_xray_seed[47], ~bmask[47]),
    SliderHashT.init(bishop_xray_offset[48], bishop_xray_seed[48], ~bmask[48]),
    SliderHashT.init(bishop_xray_offset[49], bishop_xray_seed[49], ~bmask[49]),
    SliderHashT.init(bishop_xray_offset[50], bishop_xray_seed[50], ~bmask[50]),
    SliderHashT.init(bishop_xray_offset[51], bishop_xray_seed[51], ~bmask[51]),
    SliderHashT.init(bishop_xray_offset[52], bishop_xray_seed[52], ~bmask[52]),
    SliderHashT.init(bishop_xray_offset[53], bishop_xray_seed[53], ~bmask[53]),
    SliderHashT.init(bishop_xray_offset[54], bishop_xray_seed[54], ~bmask[54]),
    SliderHashT.init(bishop_xray_offset[55], bishop_xray_seed[55], ~bmask[55]),
    SliderHashT.init(bishop_xray_offset[56], bishop_xray_seed[56], ~bmask[56]),
    SliderHashT.init(bishop_xray_offset[57], bishop_xray_seed[57], ~bmask[57]),
    SliderHashT.init(bishop_xray_offset[58], bishop_xray_seed[58], ~bmask[58]),
    SliderHashT.init(bishop_xray_offset[59], bishop_xray_seed[59], ~bmask[59]),
    SliderHashT.init(bishop_xray_offset[60], bishop_xray_seed[60], ~bmask[60]),
    SliderHashT.init(bishop_xray_offset[61], bishop_xray_seed[61], ~bmask[61]),
    SliderHashT.init(bishop_xray_offset[62], bishop_xray_seed[62], ~bmask[62]),
    SliderHashT.init(bishop_xray_offset[63], bishop_xray_seed[63], ~bmask[63]),
};

pub const pext_rook_attacks = [64]SliderPextT{
    SliderPextT.init(rook_offset_pext[0], rmask[0]),
    SliderPextT.init(rook_offset_pext[1], rmask[1]),
    SliderPextT.init(rook_offset_pext[2], rmask[2]),
    SliderPextT.init(rook_offset_pext[3], rmask[3]),
    SliderPextT.init(rook_offset_pext[4], rmask[4]),
    SliderPextT.init(rook_offset_pext[5], rmask[5]),
    SliderPextT.init(rook_offset_pext[6], rmask[6]),
    SliderPextT.init(rook_offset_pext[7], rmask[7]),
    SliderPextT.init(rook_offset_pext[8], rmask[8]),
    SliderPextT.init(rook_offset_pext[9], rmask[9]),
    SliderPextT.init(rook_offset_pext[10], rmask[10]),
    SliderPextT.init(rook_offset_pext[11], rmask[11]),
    SliderPextT.init(rook_offset_pext[12], rmask[12]),
    SliderPextT.init(rook_offset_pext[13], rmask[13]),
    SliderPextT.init(rook_offset_pext[14], rmask[14]),
    SliderPextT.init(rook_offset_pext[15], rmask[15]),
    SliderPextT.init(rook_offset_pext[16], rmask[16]),
    SliderPextT.init(rook_offset_pext[17], rmask[17]),
    SliderPextT.init(rook_offset_pext[18], rmask[18]),
    SliderPextT.init(rook_offset_pext[19], rmask[19]),
    SliderPextT.init(rook_offset_pext[20], rmask[20]),
    SliderPextT.init(rook_offset_pext[21], rmask[21]),
    SliderPextT.init(rook_offset_pext[22], rmask[22]),
    SliderPextT.init(rook_offset_pext[23], rmask[23]),
    SliderPextT.init(rook_offset_pext[24], rmask[24]),
    SliderPextT.init(rook_offset_pext[25], rmask[25]),
    SliderPextT.init(rook_offset_pext[26], rmask[26]),
    SliderPextT.init(rook_offset_pext[27], rmask[27]),
    SliderPextT.init(rook_offset_pext[28], rmask[28]),
    SliderPextT.init(rook_offset_pext[29], rmask[29]),
    SliderPextT.init(rook_offset_pext[30], rmask[30]),
    SliderPextT.init(rook_offset_pext[31], rmask[31]),
    SliderPextT.init(rook_offset_pext[32], rmask[32]),
    SliderPextT.init(rook_offset_pext[33], rmask[33]),
    SliderPextT.init(rook_offset_pext[34], rmask[34]),
    SliderPextT.init(rook_offset_pext[35], rmask[35]),
    SliderPextT.init(rook_offset_pext[36], rmask[36]),
    SliderPextT.init(rook_offset_pext[37], rmask[37]),
    SliderPextT.init(rook_offset_pext[38], rmask[38]),
    SliderPextT.init(rook_offset_pext[39], rmask[39]),
    SliderPextT.init(rook_offset_pext[40], rmask[40]),
    SliderPextT.init(rook_offset_pext[41], rmask[41]),
    SliderPextT.init(rook_offset_pext[42], rmask[42]),
    SliderPextT.init(rook_offset_pext[43], rmask[43]),
    SliderPextT.init(rook_offset_pext[44], rmask[44]),
    SliderPextT.init(rook_offset_pext[45], rmask[45]),
    SliderPextT.init(rook_offset_pext[46], rmask[46]),
    SliderPextT.init(rook_offset_pext[47], rmask[47]),
    SliderPextT.init(rook_offset_pext[48], rmask[48]),
    SliderPextT.init(rook_offset_pext[49], rmask[49]),
    SliderPextT.init(rook_offset_pext[50], rmask[50]),
    SliderPextT.init(rook_offset_pext[51], rmask[51]),
    SliderPextT.init(rook_offset_pext[52], rmask[52]),
    SliderPextT.init(rook_offset_pext[53], rmask[53]),
    SliderPextT.init(rook_offset_pext[54], rmask[54]),
    SliderPextT.init(rook_offset_pext[55], rmask[55]),
    SliderPextT.init(rook_offset_pext[56], rmask[56]),
    SliderPextT.init(rook_offset_pext[57], rmask[57]),
    SliderPextT.init(rook_offset_pext[58], rmask[58]),
    SliderPextT.init(rook_offset_pext[59], rmask[59]),
    SliderPextT.init(rook_offset_pext[60], rmask[60]),
    SliderPextT.init(rook_offset_pext[61], rmask[61]),
    SliderPextT.init(rook_offset_pext[62], rmask[62]),
    SliderPextT.init(rook_offset_pext[63], rmask[63]),
};
pub const pext_bishop_attacks = [64]SliderPextT{
    SliderPextT.init(bishop_offset_pext[0], bmask[0]),
    SliderPextT.init(bishop_offset_pext[1], bmask[1]),
    SliderPextT.init(bishop_offset_pext[2], bmask[2]),
    SliderPextT.init(bishop_offset_pext[3], bmask[3]),
    SliderPextT.init(bishop_offset_pext[4], bmask[4]),
    SliderPextT.init(bishop_offset_pext[5], bmask[5]),
    SliderPextT.init(bishop_offset_pext[6], bmask[6]),
    SliderPextT.init(bishop_offset_pext[7], bmask[7]),
    SliderPextT.init(bishop_offset_pext[8], bmask[8]),
    SliderPextT.init(bishop_offset_pext[9], bmask[9]),
    SliderPextT.init(bishop_offset_pext[10], bmask[10]),
    SliderPextT.init(bishop_offset_pext[11], bmask[11]),
    SliderPextT.init(bishop_offset_pext[12], bmask[12]),
    SliderPextT.init(bishop_offset_pext[13], bmask[13]),
    SliderPextT.init(bishop_offset_pext[14], bmask[14]),
    SliderPextT.init(bishop_offset_pext[15], bmask[15]),
    SliderPextT.init(bishop_offset_pext[16], bmask[16]),
    SliderPextT.init(bishop_offset_pext[17], bmask[17]),
    SliderPextT.init(bishop_offset_pext[18], bmask[18]),
    SliderPextT.init(bishop_offset_pext[19], bmask[19]),
    SliderPextT.init(bishop_offset_pext[20], bmask[20]),
    SliderPextT.init(bishop_offset_pext[21], bmask[21]),
    SliderPextT.init(bishop_offset_pext[22], bmask[22]),
    SliderPextT.init(bishop_offset_pext[23], bmask[23]),
    SliderPextT.init(bishop_offset_pext[24], bmask[24]),
    SliderPextT.init(bishop_offset_pext[25], bmask[25]),
    SliderPextT.init(bishop_offset_pext[26], bmask[26]),
    SliderPextT.init(bishop_offset_pext[27], bmask[27]),
    SliderPextT.init(bishop_offset_pext[28], bmask[28]),
    SliderPextT.init(bishop_offset_pext[29], bmask[29]),
    SliderPextT.init(bishop_offset_pext[30], bmask[30]),
    SliderPextT.init(bishop_offset_pext[31], bmask[31]),
    SliderPextT.init(bishop_offset_pext[32], bmask[32]),
    SliderPextT.init(bishop_offset_pext[33], bmask[33]),
    SliderPextT.init(bishop_offset_pext[34], bmask[34]),
    SliderPextT.init(bishop_offset_pext[35], bmask[35]),
    SliderPextT.init(bishop_offset_pext[36], bmask[36]),
    SliderPextT.init(bishop_offset_pext[37], bmask[37]),
    SliderPextT.init(bishop_offset_pext[38], bmask[38]),
    SliderPextT.init(bishop_offset_pext[39], bmask[39]),
    SliderPextT.init(bishop_offset_pext[40], bmask[40]),
    SliderPextT.init(bishop_offset_pext[41], bmask[41]),
    SliderPextT.init(bishop_offset_pext[42], bmask[42]),
    SliderPextT.init(bishop_offset_pext[43], bmask[43]),
    SliderPextT.init(bishop_offset_pext[44], bmask[44]),
    SliderPextT.init(bishop_offset_pext[45], bmask[45]),
    SliderPextT.init(bishop_offset_pext[46], bmask[46]),
    SliderPextT.init(bishop_offset_pext[47], bmask[47]),
    SliderPextT.init(bishop_offset_pext[48], bmask[48]),
    SliderPextT.init(bishop_offset_pext[49], bmask[49]),
    SliderPextT.init(bishop_offset_pext[50], bmask[50]),
    SliderPextT.init(bishop_offset_pext[51], bmask[51]),
    SliderPextT.init(bishop_offset_pext[52], bmask[52]),
    SliderPextT.init(bishop_offset_pext[53], bmask[53]),
    SliderPextT.init(bishop_offset_pext[54], bmask[54]),
    SliderPextT.init(bishop_offset_pext[55], bmask[55]),
    SliderPextT.init(bishop_offset_pext[56], bmask[56]),
    SliderPextT.init(bishop_offset_pext[57], bmask[57]),
    SliderPextT.init(bishop_offset_pext[58], bmask[58]),
    SliderPextT.init(bishop_offset_pext[59], bmask[59]),
    SliderPextT.init(bishop_offset_pext[60], bmask[60]),
    SliderPextT.init(bishop_offset_pext[61], bmask[61]),
    SliderPextT.init(bishop_offset_pext[62], bmask[62]),
    SliderPextT.init(bishop_offset_pext[63], bmask[63]),
};
pub const pext_rook_attacks_xray = [64]SliderPextT{
    SliderPextT.init(rook_xray_offset_pext[0], rmask[0]),
    SliderPextT.init(rook_xray_offset_pext[1], rmask[1]),
    SliderPextT.init(rook_xray_offset_pext[2], rmask[2]),
    SliderPextT.init(rook_xray_offset_pext[3], rmask[3]),
    SliderPextT.init(rook_xray_offset_pext[4], rmask[4]),
    SliderPextT.init(rook_xray_offset_pext[5], rmask[5]),
    SliderPextT.init(rook_xray_offset_pext[6], rmask[6]),
    SliderPextT.init(rook_xray_offset_pext[7], rmask[7]),
    SliderPextT.init(rook_xray_offset_pext[8], rmask[8]),
    SliderPextT.init(rook_xray_offset_pext[9], rmask[9]),
    SliderPextT.init(rook_xray_offset_pext[10], rmask[10]),
    SliderPextT.init(rook_xray_offset_pext[11], rmask[11]),
    SliderPextT.init(rook_xray_offset_pext[12], rmask[12]),
    SliderPextT.init(rook_xray_offset_pext[13], rmask[13]),
    SliderPextT.init(rook_xray_offset_pext[14], rmask[14]),
    SliderPextT.init(rook_xray_offset_pext[15], rmask[15]),
    SliderPextT.init(rook_xray_offset_pext[16], rmask[16]),
    SliderPextT.init(rook_xray_offset_pext[17], rmask[17]),
    SliderPextT.init(rook_xray_offset_pext[18], rmask[18]),
    SliderPextT.init(rook_xray_offset_pext[19], rmask[19]),
    SliderPextT.init(rook_xray_offset_pext[20], rmask[20]),
    SliderPextT.init(rook_xray_offset_pext[21], rmask[21]),
    SliderPextT.init(rook_xray_offset_pext[22], rmask[22]),
    SliderPextT.init(rook_xray_offset_pext[23], rmask[23]),
    SliderPextT.init(rook_xray_offset_pext[24], rmask[24]),
    SliderPextT.init(rook_xray_offset_pext[25], rmask[25]),
    SliderPextT.init(rook_xray_offset_pext[26], rmask[26]),
    SliderPextT.init(rook_xray_offset_pext[27], rmask[27]),
    SliderPextT.init(rook_xray_offset_pext[28], rmask[28]),
    SliderPextT.init(rook_xray_offset_pext[29], rmask[29]),
    SliderPextT.init(rook_xray_offset_pext[30], rmask[30]),
    SliderPextT.init(rook_xray_offset_pext[31], rmask[31]),
    SliderPextT.init(rook_xray_offset_pext[32], rmask[32]),
    SliderPextT.init(rook_xray_offset_pext[33], rmask[33]),
    SliderPextT.init(rook_xray_offset_pext[34], rmask[34]),
    SliderPextT.init(rook_xray_offset_pext[35], rmask[35]),
    SliderPextT.init(rook_xray_offset_pext[36], rmask[36]),
    SliderPextT.init(rook_xray_offset_pext[37], rmask[37]),
    SliderPextT.init(rook_xray_offset_pext[38], rmask[38]),
    SliderPextT.init(rook_xray_offset_pext[39], rmask[39]),
    SliderPextT.init(rook_xray_offset_pext[40], rmask[40]),
    SliderPextT.init(rook_xray_offset_pext[41], rmask[41]),
    SliderPextT.init(rook_xray_offset_pext[42], rmask[42]),
    SliderPextT.init(rook_xray_offset_pext[43], rmask[43]),
    SliderPextT.init(rook_xray_offset_pext[44], rmask[44]),
    SliderPextT.init(rook_xray_offset_pext[45], rmask[45]),
    SliderPextT.init(rook_xray_offset_pext[46], rmask[46]),
    SliderPextT.init(rook_xray_offset_pext[47], rmask[47]),
    SliderPextT.init(rook_xray_offset_pext[48], rmask[48]),
    SliderPextT.init(rook_xray_offset_pext[49], rmask[49]),
    SliderPextT.init(rook_xray_offset_pext[50], rmask[50]),
    SliderPextT.init(rook_xray_offset_pext[51], rmask[51]),
    SliderPextT.init(rook_xray_offset_pext[52], rmask[52]),
    SliderPextT.init(rook_xray_offset_pext[53], rmask[53]),
    SliderPextT.init(rook_xray_offset_pext[54], rmask[54]),
    SliderPextT.init(rook_xray_offset_pext[55], rmask[55]),
    SliderPextT.init(rook_xray_offset_pext[56], rmask[56]),
    SliderPextT.init(rook_xray_offset_pext[57], rmask[57]),
    SliderPextT.init(rook_xray_offset_pext[58], rmask[58]),
    SliderPextT.init(rook_xray_offset_pext[59], rmask[59]),
    SliderPextT.init(rook_xray_offset_pext[60], rmask[60]),
    SliderPextT.init(rook_xray_offset_pext[61], rmask[61]),
    SliderPextT.init(rook_xray_offset_pext[62], rmask[62]),
    SliderPextT.init(rook_xray_offset_pext[63], rmask[63]),
};
pub const pext_bishop_attacks_xray = [64]SliderPextT{
    SliderPextT.init(bishop_xray_offset_pext[0], bmask[0]),
    SliderPextT.init(bishop_xray_offset_pext[1], bmask[1]),
    SliderPextT.init(bishop_xray_offset_pext[2], bmask[2]),
    SliderPextT.init(bishop_xray_offset_pext[3], bmask[3]),
    SliderPextT.init(bishop_xray_offset_pext[4], bmask[4]),
    SliderPextT.init(bishop_xray_offset_pext[5], bmask[5]),
    SliderPextT.init(bishop_xray_offset_pext[6], bmask[6]),
    SliderPextT.init(bishop_xray_offset_pext[7], bmask[7]),
    SliderPextT.init(bishop_xray_offset_pext[8], bmask[8]),
    SliderPextT.init(bishop_xray_offset_pext[9], bmask[9]),
    SliderPextT.init(bishop_xray_offset_pext[10], bmask[10]),
    SliderPextT.init(bishop_xray_offset_pext[11], bmask[11]),
    SliderPextT.init(bishop_xray_offset_pext[12], bmask[12]),
    SliderPextT.init(bishop_xray_offset_pext[13], bmask[13]),
    SliderPextT.init(bishop_xray_offset_pext[14], bmask[14]),
    SliderPextT.init(bishop_xray_offset_pext[15], bmask[15]),
    SliderPextT.init(bishop_xray_offset_pext[16], bmask[16]),
    SliderPextT.init(bishop_xray_offset_pext[17], bmask[17]),
    SliderPextT.init(bishop_xray_offset_pext[18], bmask[18]),
    SliderPextT.init(bishop_xray_offset_pext[19], bmask[19]),
    SliderPextT.init(bishop_xray_offset_pext[20], bmask[20]),
    SliderPextT.init(bishop_xray_offset_pext[21], bmask[21]),
    SliderPextT.init(bishop_xray_offset_pext[22], bmask[22]),
    SliderPextT.init(bishop_xray_offset_pext[23], bmask[23]),
    SliderPextT.init(bishop_xray_offset_pext[24], bmask[24]),
    SliderPextT.init(bishop_xray_offset_pext[25], bmask[25]),
    SliderPextT.init(bishop_xray_offset_pext[26], bmask[26]),
    SliderPextT.init(bishop_xray_offset_pext[27], bmask[27]),
    SliderPextT.init(bishop_xray_offset_pext[28], bmask[28]),
    SliderPextT.init(bishop_xray_offset_pext[29], bmask[29]),
    SliderPextT.init(bishop_xray_offset_pext[30], bmask[30]),
    SliderPextT.init(bishop_xray_offset_pext[31], bmask[31]),
    SliderPextT.init(bishop_xray_offset_pext[32], bmask[32]),
    SliderPextT.init(bishop_xray_offset_pext[33], bmask[33]),
    SliderPextT.init(bishop_xray_offset_pext[34], bmask[34]),
    SliderPextT.init(bishop_xray_offset_pext[35], bmask[35]),
    SliderPextT.init(bishop_xray_offset_pext[36], bmask[36]),
    SliderPextT.init(bishop_xray_offset_pext[37], bmask[37]),
    SliderPextT.init(bishop_xray_offset_pext[38], bmask[38]),
    SliderPextT.init(bishop_xray_offset_pext[39], bmask[39]),
    SliderPextT.init(bishop_xray_offset_pext[40], bmask[40]),
    SliderPextT.init(bishop_xray_offset_pext[41], bmask[41]),
    SliderPextT.init(bishop_xray_offset_pext[42], bmask[42]),
    SliderPextT.init(bishop_xray_offset_pext[43], bmask[43]),
    SliderPextT.init(bishop_xray_offset_pext[44], bmask[44]),
    SliderPextT.init(bishop_xray_offset_pext[45], bmask[45]),
    SliderPextT.init(bishop_xray_offset_pext[46], bmask[46]),
    SliderPextT.init(bishop_xray_offset_pext[47], bmask[47]),
    SliderPextT.init(bishop_xray_offset_pext[48], bmask[48]),
    SliderPextT.init(bishop_xray_offset_pext[49], bmask[49]),
    SliderPextT.init(bishop_xray_offset_pext[50], bmask[50]),
    SliderPextT.init(bishop_xray_offset_pext[51], bmask[51]),
    SliderPextT.init(bishop_xray_offset_pext[52], bmask[52]),
    SliderPextT.init(bishop_xray_offset_pext[53], bmask[53]),
    SliderPextT.init(bishop_xray_offset_pext[54], bmask[54]),
    SliderPextT.init(bishop_xray_offset_pext[55], bmask[55]),
    SliderPextT.init(bishop_xray_offset_pext[56], bmask[56]),
    SliderPextT.init(bishop_xray_offset_pext[57], bmask[57]),
    SliderPextT.init(bishop_xray_offset_pext[58], bmask[58]),
    SliderPextT.init(bishop_xray_offset_pext[59], bmask[59]),
    SliderPextT.init(bishop_xray_offset_pext[60], bmask[60]),
    SliderPextT.init(bishop_xray_offset_pext[61], bmask[61]),
    SliderPextT.init(bishop_xray_offset_pext[62], bmask[62]),
    SliderPextT.init(bishop_xray_offset_pext[63], bmask[63]),
};

pub const LookupSwitch = struct {
    pub inline fn king(square: u64) u64 {
        return king_attacks[square];
    }

    pub inline fn knight(square: u64) u64 {
        return knight_attacks[square];
    }

    pub inline fn rook(square: u64, occupy: u64) u64 {
        return getSliderHCond(square, occupy) | getSliderVCond(square, occupy);
    }

    pub inline fn rookXRay(square: u64, occupy: u64) u64 {
        const attacks = rook(square, occupy);
        return attacks ^ rook(square, occupy ^ (attacks & occupy));
    }

    pub inline fn bishop(square: u64, occupy: u64) u64 {
        return getSliderD1Cond(square, occupy) | getSliderD2Cond(square, occupy);
    }

    pub inline fn bishopXRay(square: u64, occupy: u64) u64 {
        const attacks = bishop(square, occupy);
        return attacks ^ bishop(square, occupy ^ (attacks & occupy));
    }

    pub inline fn queen(square: u64, occupy: u64) u64 {
        return rook(square, occupy) | bishop(square, occupy);
    }

    pub inline fn queenXRay(square: u64, occupy: u64) u64 {
        return rookXRay(square, occupy) | bishop(square, occupy);
    }
};

pub const LookupHash = struct {
    pub inline fn king(square: u64) u64 {
        return king[square];
    }

    pub inline fn knight(square: u64) u64 {
        return knight_attacks[square];
    }

    pub inline fn rook(square: u64, occupy: u64) u64 {
        return hash_rook_attacks[square].get(occupy);
    }

    pub inline fn rookXRay(square: u64, occupy: u64) u64 {
        return hash_rook_attacks_xray[square].get(occupy);
    }

    pub inline fn bishop(square: u64, occupy: u64) u64 {
        return hash_bishop_attacks[square].get(occupy);
    }

    pub inline fn bishopXRay(square: u64, occupy: u64) u64 {
        return hash_bishop_attacks_xray[square].get(occupy);
    }

    pub inline fn queen(square: u64, occupy: u64) u64 {
        return rook(square, occupy) | bishop(square, occupy);
    }

    pub inline fn queenXRay(square: u64, occupy: u64) u64 {
        return rookXRay(square, occupy) | bishop(square, occupy);
    }
};

pub const LookupPext = struct {
    pub inline fn king(square: u64) u64 {
        return king_attacks[square];
    }

    pub inline fn knight(square: u64) u64 {
        return knight_attacks[square];
    }

    pub inline fn rook(square: u64, occupy: u64) u64 {
        return pext_rook_attacks[square].get(occupy);
    }

    pub inline fn rookXRay(square: u64, occupy: u64) u64 {
        return pext_rook_attacks_xray[square].get(occupy);
    }

    pub inline fn bishop(square: u64, occupy: u64) u64 {
        return pext_bishop_attacks[square].get(occupy);
    }

    pub inline fn bishopXRay(square: u64, occupy: u64) u64 {
        return pext_bishop_attacks_xray[square].get(occupy);
    }

    pub inline fn queen(square: u64, occupy: u64) u64 {
        return rook(square, occupy) | bishop(square, occupy);
    }

    pub inline fn queenXRay(square: u64, occupy: u64) u64 {
        return rookXRay(square, occupy) | bishop(square, occupy);
    }
};
