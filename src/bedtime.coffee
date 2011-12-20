fs = require 'fs'
xmpp = require 'node-xmpp'
oembed = require 'oembed'

NS_STANZAS = 'urn:ietf:params:xml:ns:xmpp-stanzas'
NS_OEMBED = 'http://github.com/buddycloud/bedtime'

if process.argv.length < 3
    console.error "Usage: " + process.argv.join(" ") + " <config.json>"
    process.exit 1

config = JSON.parse fs.readFileSync(process.argv[2])
config.xmpp.reconnect = true
conn = new xmpp.Component(config.xmpp)


makeReply = (stanza, type) ->
    reply = new xmpp.Element(stanza.name)
    reply.attrs.from = stanza.attrs.to
    reply.attrs.to = stanza.attrs.from
    reply.attrs.id = stanza.attrs.id
    reply.attrs.type = type
    reply

conn.on 'stanza', (stanza) ->
    # Handle all <iq/> requests
    if stanza.getName() is 'iq' and
       stanza.attrs.type isnt 'error'

        # oEmbed query specific handling
        oembedEl = stanza.getChild('oembed', NS_OEMBED)
        url = oembedEl?.attrs.url
        if stanza.attrs.type is 'get' and url?
            oembed.fetch url, oembedEl.attrs, (error, result) ->
                if result
                    resultEl = makeReply(stanza, 'result').
                        c('oembed', xmlns: NS_OEMBED)
                    for own k, v of result
                        resultEl.c(k).t(v)
                    conn.send resultEl.root()
                else
                    console.error error or "No oEmbed result"
                    conn.send makeReply(stanza, 'error').
                        c('error', type: 'cancel').
                        c('internal-server-error', xmlns: NS_STANZAS).up().
                        c('text', xmlns: NS_STANZAS).
                        t(error.message or "No oEmbed result")
        else
            conn.send makeReply(stanza, 'error').
                c('error', type: 'cancel').
                c('feature-not-implemented', xmlns: NS_STANZAS)

