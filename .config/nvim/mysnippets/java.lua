return {
    s("main2", t({
        'public static void main(String[] args) {',
        '    System.out.println("2")',
        '}'})
    ),

    s({
        trig = "measure",
        descr = "Simple time measurement code. Obtain current millis and print time difference."
    },
    {
        t({ 'long start = System.currentTimeMillis();', ''}),
        i(1),
        t({'', 'System.out.printf("Time: %d %n", System.currentTimeMillis() - start);'}),
    }),

    s({
        trig = "logd",
        descr = "SLF4J Logger declaration."
    },
    {
        -- Declare SLF4J logger with current class
        t({'private static final Logger LOGGER = LoggerFactory.getLogger('}),

        f(function()
            local class = require('anton.java.utils').get_current_class()
            return tostring(class) .. '.class'
        end, {}),

        t({');'}),
    }),

    s("testdoc", {
        t({'Тест класса {@'}),

        f(function()
            local class = require('anton.java.utils').get_current_class()
            return tostring(class)
        end, {}),

        t({'}'}),
    }),

    s("checka", {
        f(function()
            local parameters = require('anton.java.utils').get_current_method_parameters()
            if parameters == nil then
                return ''
            end

            local result = {}
            for _, parameter in ipairs(parameters) do
               table.insert(result, string.format('Argument.checkNotNull(%s, "Argument \'%s\' must not be null!");', parameter, parameter))
            end
            return result
        end, {}),
    })
}
