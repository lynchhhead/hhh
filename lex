#include <stdio.h>
#include <stdint.h>
#include <locale.h>

int main(void) {
    setlocale(LC_ALL, "Russian");
    printf("=== Арифметика (деление, остаток, переполнения unsigned) ===\n");
    {
        int a = -7, b = 3;
        int q = a / b;     /* усечение к 0 */
        int r = a % b;     /* остаток имеет знак делимого */
        printf("C: %d / %d = %d\n", a, b, q);
        printf("C: %d %% %d = %d\n", a, b, r);

        unsigned int u = 0xFFFFFFFFu;
        unsigned int uw = u + 1u;   /* переполнение unsigned — модуль 2^32 */
        printf("C: 0xFFFFFFFF + 1 (unsigned) = 0x%08X\n", uw);

        double d = 5.0 / 2.0;
        printf("C: 5.0 / 2.0 = %.3f\n", d);
    }

    printf("\n=== Логические операторы vs побитовые ===\n");
    {
        int x = 0, y = 42;
        int l_and = x && y;         /* 0/1 */
        int l_or = x || y;         /* 0/1 */
        int l_not = !x;             /* 1 */
        printf("C: 0 && 42 = %d, 0 || 42 = %d, !0 = %d\n", l_and, l_or, l_not);

        int a = 3, b = 4;
        int logic = a && b;         /* 1 (оба ненулевые) */
        int bit = a & b;          /* 3 (0b011 & 0b100 == 0) → на самом деле 0, но 3&4=0 */
        printf("C: 3 && 4 = %d, 3 & 4 = %d\n", logic, bit);
    }

    printf("\n=== Побитовые операции и маски ===\n");
    {
        /* флаги: RX, TX, ERR */
        const uint32_t FLAG_RX = 1u << 0;
        const uint32_t FLAG_TX = 1u << 1;
        const uint32_t FLAG_ERR = 1u << 2;

        uint32_t flags = 0;
        flags |= FLAG_RX;
        flags |= FLAG_TX;
        printf("flags после RX|TX: 0x%X\n", flags);

        flags &= ~FLAG_RX;
        printf("flags после сброса RX: 0x%X\n", flags);

        if (flags & FLAG_TX) {
            printf("FLAG_TX установлен\n");
        }

        flags ^= FLAG_TX;
        printf("flags после toggle TX: 0x%X\n", flags);
    }

    printf("\n=== Приоритет: a & b == c и скобки ===\n");
    {
        int pa = 3, pb = 6, pc = 4;
        int r1 = pa & pb == pc;       /* в C: pa & (pb == pc) */
        int r2 = (pa & pb) == pc;     /* ожидаемое намерение */
        printf("C: pa & pb == pc  -> %d\n", r1);
        printf("C: (pa & pb) == pc -> %d\n", r2);
    }

    printf("\n=== Короткое замыкание (&&, ||) ===\n");
    {
        const char* p = NULL;
        /* безопасно: правое выражение не выполнится при p == NULL */
        int safe = (p != NULL) && (p[0] == 'A');
        printf("C: (p!=NULL)&&(p[0]=='A') -> %d\n", safe);

        /* ВНИМАНИЕ: побитовое & вычислит оба операнда — делать так нельзя! */
        /* int unsafe = (p != NULL) & (p[0] == 'A'); */
    }

    printf("\n=== Условные конструкции: if/else, ?:, switch ===\n");
    {
        int v = -5;
        if (v < 0) {
            printf("if: v < 0\n");
        }
        else if (v == 0) {
            printf("if: v == 0\n");
        }
        else {
            printf("if: v > 0\n");
        }

        /* тернарный оператор */
        int abs_v = (v >= 0) ? v : -v;
        printf("?: abs(%d) = %d\n", v, abs_v);

        /* switch по коду операции */
        char op = '+';
        switch (op) {
        case '+': printf("switch: выбрано сложение\n"); break;
        case '-': printf("switch: выбрано вычитание\n"); break;
        default:  printf("switch: неизвестная операция\n"); break;
        }
    }

    printf("\n=== Сдвиги: только беззнаковые и в допустимых диапазонах ===\n");
    {
        uint32_t n = 5u;
        unsigned shift = 3u; /* 0..31 */
        uint32_t res = n << shift;    /* 5 << 3 = 40 */
        printf("C: 5 << 3 = %u\n", res);

        /* проверка безопасного формирования маски по позиции */
        unsigned bit = 31u;
        uint32_t mask = (bit < 32u) ? (1u << bit) : 0u;
        printf("mask для бита 31: 0x%08X\n", mask);
    }

    printf("\nГотово.\n");
    return 0;
}