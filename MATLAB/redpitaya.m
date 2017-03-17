%% Define Red Pitaya as TCP/IP object

IP= '192.168.1.99';           % Input IP of your Red Pitaya...
port = 5000;
tcpipObj=tcpip(IP, port);

%% Open connection with your Red Pitaya

fopen(tcpipObj);
tcpipObj.Terminator = 'CR/LF';

%% Send SCPI command to Red Pitaya to turn ON LED1

fprintf(tcpipObj,'DIG:PIN LED1,1');

pause(5)                         % Set time of LED ON

%% Send SCPI command to Red Pitaya to turn OFF LED1

fprintf(tcpipObj,'DIG:PIN LED1,0');

%% Close connection with Red Pitaya

fclose(tcpipObj);
view rawdigital_led_blink.m
Code - C

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "redpitaya/rp.h"

int main (int argc, char **argv) {
    int unsigned period = 1000000; // uS
    int unsigned led;

    // index of blinking LED can be provided as an argument
    if (argc > 1) {
        led = atoi(argv[1]);
    // otherwise LED 0 will blink
    } else {
        led = 0;
    }
    printf("Blinking LED[%u]\n", led);
    led += RP_LED0;

    // Initialization of API
    if (rp_Init() != RP_OK) {
        fprintf(stderr, "Red Pitaya API init failed!\n");
        return EXIT_FAILURE;
    }

    int unsigned retries = 1000;
    while (retries--){
        rp_DpinSetState(led, RP_HIGH);
        usleep(period/2);
        rp_DpinSetState(led, RP_LOW);
        usleep(period/2);
    }

    // Releasing resources
    rp_Release();

    return EXIT_SUCCESS;
}