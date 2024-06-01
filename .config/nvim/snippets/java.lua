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

    s({
        trig = "testdoc",
        descr = "Basic javadoc for unit test class",
    },
    {
        f(function()
            local current_file = require('anton.core.utils').get_current_file()
            local name_without_extension = vim.fn.fnamemodify(current_file, ':t:r')
            return string.format('Тест класса {@link %s}', tostring(name_without_extension))
        end, {}),
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
    }),

    s({
        trig = "jbangclass",
        descr = "JBang class template",
    },
    {
        t({
            '//usr/bin/env jbang "$0" "$@" ; exit $?',
            '',
            '//JAVA 11',
            '',
            '//REPOS mavencentral,qulix=https://cs-repo.qulix.com/repository/public,qulixsnapshot=https://cs-repo.qulix.com/repository/public-snapshots',
            '',
            '//DEPS com.qulix.testkit:testkit-selenium:0.9.0',
            '',
            'class Tool {',
            '    public static void main(String[] args) {',
            '',
        }),
        i(1),
        t({
            '',
            '    }',
            '}',
        }),
    }),

    s({
        trig = "testmethod",
        descr = "JUnit test method",
    },
    {
        t({
            '@Test',
            'void name() throws Exception {',
            '',
        }),
        i(1),
        t({
            '',
            '}',
        }),
    }),
}
