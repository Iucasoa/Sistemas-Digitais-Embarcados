#include <avr/io.h>
#include <util/delay.h>

int main(void) {

    DDRB &= ~(1 << 4);

    PORTB |= (1 << 4);

    DDRB |= (1 << 5);
    

    while (1) {

        if ( (PINB & (1 << 4)) == (1<<4) ) {

            PORTB |= (1 << 5);
            
        }
        else{
            PORTB &= ~(1 << 5);
        }
        _delay_ms(750);
    }
    return 0;
}
