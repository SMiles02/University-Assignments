#include <bits/stdc++.h>
using namespace std;

const int MAX_N = 500;
const int K = 1000; // Annealing iterations

int f(vector<int> &q, int n) {
    int tot = 0;
    for (int i = 0; i < n; i++) {
        bool no_col = true;
        for (int j = 0; j < i; j++) {
            if (abs(i - j) == abs(q[i] - q[j])) {
                no_col = false;
            }
        }
        tot += no_col;
    }
    return tot;
}

double rnd() { return double(rand()) / RAND_MAX; }

void anneal_queens(int n) {
    vector<int> v(n);
    iota(v.begin(), v.end(), 0);
    random_shuffle(v.begin(), v.end());
    int ans = f(v, n);
    double t = 50, mpl = pow((1e-5) / t, (double) 1 / K);
    for (int i = 0; i < K && ans < n; i++) {
        t *= 0.99;
        vector<int> u = v;
        swap(u[rand() % n], u[rand() % n]);
        int new_val = f(u, n);
        if (new_val > ans || rnd() < exp((new_val - ans) / t)) {
            v = u;
            ans = new_val;
        }
    }

    // for (int x : v) {
    //     cout << x + 1 << " ";
    // }
}

int main() {
    srand(1);
    vector<double> times;
    for (int i = 5; i <= MAX_N; i += 5) {
        int start_time = clock();
        anneal_queens(i);
        times.push_back((clock() - start_time) / double(CLOCKS_PER_SEC));
        cout << i << ": " << times.back() << "\n";
    }
    return 0;
}
