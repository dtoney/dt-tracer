#ifndef COLOR_TEST_H
#define COLOR_TEST_H

namespace SRT
{
class ColorTest
{
public:
    // public methods
    ColorTest()  = default;
    ~ColorTest() = default;

    void Run();

private:
    // private data

    void GenerateScene();
};

} // namespace SRT

#endif // COLOR_TEST_H
