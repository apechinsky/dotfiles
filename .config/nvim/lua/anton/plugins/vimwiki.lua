-- Personal Wiki for Vim http://vimwiki.github.io/
return {
    'vimwiki/vimwiki',

    init = function ()
        -- Do not shorten URLs
        vim.g.vimwiki_url_maxsave = 0

        -- Enable temporary wiki
        vim.g.vimwiki_global_ext = 1
        vim.g.vimwiki_ext2syntax = {
            ['.wiki'] = 'default',
            ['.mwiki'] = 'markdown',
        }

        local personal = {
            path = '~/Dropbox/vimwiki/personal',
            path_html = '~/Dropbox/vimwiki/personal/html',
            syntax = 'markdown',
            ext = '.md',
            auto_tags = 1,
        }

        local work = {
            path = '~/Dropbox/vimwiki/work',
            path_html = '~/Dropbox/vimwiki/work/html',
            syntax = 'markdown',
            ext = '.md',
            auto_tags = 1,
        }

        local test = {
            path = '~/Dropbox/vimwiki/test',
            path_html = '~/Dropbox/vimwiki/test/html',
            syntax = 'default',
            ext = '.wiki',
            auto_tags = 1,
        }

        vim.g.vimwiki_list = { work, personal, test }
    end
}
