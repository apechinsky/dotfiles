return {
    s("trigger", {
        t({"after expanding, the cursor is here ->"}), i(1),
        t({"", "after jumping forward once, cursor is here ->"}), i(2),
        t({"", "after jumping once more, the snippet is exited there ->"}), i(0),
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
        t({"enter text"}), i(1),
        t({" duplicate: "}),
        f(function(args, parent, user_args) 
            return '[args: ' .. args[1][1] .. " user_args: " .. user_args .. ']'
        end, 1, { user_args = {"user args value " }}),
    }),

}
