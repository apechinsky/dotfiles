return {
    s("trigger", {
        t({"After expanding, the cursor is here ->"}), i(1),
        t({"", "After jumping forward once, cursor is here ->"}), i(2),
        t({"", "After jumping once more, the snippet is exited there ->"}), i(0),
    }),

    -- choice node demo
    s("trigger-choice", {
        c(1, {
            t("one"),
            t("two"),
            t("three"),
        }),
    }),

    s("trigger-function", {
        t({"Enter text"}), i(1),
        t({" duplicate: "}),
        f(function(args, parent, user_args) 
            return '[args: ' .. args[1][1] .. " user_args: " .. user_args .. ']'
        end, 1, { user_args = {"user args value " }}),
    }),

}
