//in java, you may need to put the function/method inside a class
class hanoi {
    public static void main(String[] args) {
        hanoi_java(3, new String[]{"A", "B", "C"});
    }
    private static void hanoi_java(int num, String[] disks) {
        if (num == 1) {
            System.out.printf("%s => %s\n", disks[0], disks[2]);
        } else {
            hanoi_java(num - 1, new String[]{disks[0], disks[2], disks[1]});
            System.out.printf("%s => %s\n", disks[0], disks[2]);
            hanoi_java(num - 1, new String[]{disks[1], disks[0], disks[2]});
        }
    }
}
