
/********************************************/

void test1()
{
    int a = 1;

    auto func(alias b)()
    {
        ++a;
        ++b;
    }

    int b = 1;
    func!b;
    assert(a == 2);
    assert(b == 2);

    auto dg = &func!b;
    dg();
    assert(a == 3);
    assert(b == 3);

    template TA(alias i) { int v = i; }
    mixin TA!a;
    assert(v == 3);
}

/********************************************/

struct S15
{
    int a = 1;

    struct T
    {
        int b = 10;

        // Have access to this.b, but not super.a.
        auto get()
        {
            static assert(!__traits(compiles, a++));
            return b;
        }

        struct U
        {
            int c = 100;

            // Have access to this.c, but not super.a nor super.b.
            auto get()
            {
                static assert(!__traits(compiles, a++));
                static assert(!__traits(compiles, b++));
                return c;
            }
        }
    }

    struct I(alias x)
    {
        int b = 10;

        // Have access to this.b and alias x, but not super.a.
        auto get()
        {
            static assert(!__traits(compiles, a++));
            x++;
            return x + b;
        }

        struct J(alias y)
        {
            int c = 100;

            // Have access to this.b, alias x, and alias y,
            // but not super.a nor super.b.
            auto get()
            {
                static assert(!__traits(compiles, a++));
                x++;
                static assert(!__traits(compiles, b++));
                y++;
                return x + y + c;
            }
        }
    }
}

void test15()
{
    auto a = 2;
    auto b = 4;

    // Both nested struct and struct(alias) should be equivalent.
    assert(S15.T().get == 10);
    assert(S15.T.U().get == 100);
    assert(S15.I!a().get == 13);
    assert(a == 3);
    assert(S15.I!a().J!b().get == 109);
    assert(a == 4 && b == 5);

    // Same as above, but with added nested frame.
    () {
        a = 2; b = 4;
        assert(S15.T().get == 10);
        assert(S15.T.U().get == 100);
        assert(S15.I!a().get == 13);
        assert(a == 3);
        assert(S15.I!a().J!b().get == 109);
        assert(a == 4 && b == 5);
    }();
}

/********************************************/

int runTests()
{
    test1();
    test15();
    return 0;
}

void main()
{
    runTests();          // runtime
    enum _ = runTests(); // ctfe
}
