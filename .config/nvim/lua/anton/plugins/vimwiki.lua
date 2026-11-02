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
            path = '~/Documents/vimwiki/personal',
            path_html = '~/Documents/vimwiki/personal/html',
            syntax = 'markdown',
            ext = '.md',
            auto_tags = 1,
        }

        local work = {
            path = '~/Documents/vimwiki/work',
            path_html = '~/Documents/vimwiki/work/html',
            syntax = 'markdown',
            ext = '.md',
            auto_tags = 1,
        }

        local electronics = {
            path = '~/Documents/vimwiki/electronics',
            path_html = '~/Documents/vimwiki/electronics/html',
            syntax = 'markdown',
            ext = '.md',
            auto_tags = 1,
        }

        local test = {
            path = '~/Documents/vimwiki/test',
            path_html = '~/Documents/vimwiki/test/html',
            syntax = 'default',
            ext = '.wiki',
            auto_tags = 1,
        }

        vim.g.vimwiki_list = { work, personal, electronics, test }
    end
}
