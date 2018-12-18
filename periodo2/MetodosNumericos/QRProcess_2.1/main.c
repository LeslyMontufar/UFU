#include "QRCodeEncode.h"

int main() {
    char *text;
    text = "HELLO WORLD";
    char error = _Q;
    QRCodeMain(text, error);
    return 0;
}
