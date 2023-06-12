return {
    s("main2", t({
        'public static void main(String[] args) {',
        '    System.out.println("2")',
        '}'})
    ),

    s("logd", {
        t({'private static final Logger LOGGER = LoggerFactory.getLogger('}),
        i(1),
        t({');'}),
    }),

    s("triggerj", {
        t({'value: ('}),
        i(1),
        t({') copy:'}),
        i(1),
    }),
}
