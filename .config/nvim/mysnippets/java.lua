return {
    s("main2", t({
        'public static void main(String[] args) {',
        '    System.out.println("2")',
        '}'})
    ),

    s("measure", {
        t({ 'long start = System.currentTimeMillis();', ''}),
        i(1),
        t({'', 'System.out.printf("Time: %d %n", System.currentTimeMillis() - start);'}),
    }),

    s("logd", {
        -- Declare SLF4J logger with current class
        t({'private static final Logger LOGGER = LoggerFactory.getLogger('}),

        f(function()
            local class = require('anton.java.utils').get_current_class()
            return tostring(class) .. '.class'
        end, {}),

        t({');'}),
    }),
}
