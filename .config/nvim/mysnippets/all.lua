return {
    s("trigger", {
        t({"After expanding, the cursor is here ->"}), i(1),
        t({"", "After jumping forward once, cursor is here ->"}), i(2),
        t({"", "After jumping once more, the snippet is exited there ->"}), i(0),
    }),
    s("trigger1", {
        c(1, {
            t("one"),
            t("two"),
            t("three"),
        }),
    }),
}
