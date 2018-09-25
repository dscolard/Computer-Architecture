int g = 4;

int min(int a, int b, int c) {
    int v = a;
    if (b < v)
        v = b;
    if (c < v)
        v = c;
return v;
}

int p(int i, int j, int k, int l) {
	return min(min(g, i, j), k, l);
}

int gcd(int a, int b) {
	if (b == 0) {
		return a;
	} else {
		return gcd(b, a % b);
	}
}



