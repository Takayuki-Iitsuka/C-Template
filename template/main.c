#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include <math.h>

typedef long long ll;
typedef unsigned long long ull;

#define REP(i, n) for (int i = 0; i < (int)(n); i++)
#define MIN(a, b) ((a) < (b) ? (a) : (b))
#define MAX(a, b) ((a) > (b) ? (a) : (b))

#ifdef LOCAL
#define DBG(...) (fprintf(stderr, __VA_ARGS__))
#else
#define DBG(...) ((void)0)
#endif

static int cmp_ll(const void *a, const void *b)
{
    ll x = *(const ll *)a, y = *(const ll *)b;
    return (x > y) - (x < y);
}

int main(void)
{
    ll a, b;
    if (scanf("%lld %lld", &a, &b) != 2)
        return 1;
    printf("%lld\n", a + b);
    return 0;
}
