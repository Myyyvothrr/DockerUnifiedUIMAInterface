sentence = luajava.bindClass("de.tudarmstadt.ukp.dkpro.core.api.segmentation.type.Sentence")

function serialize(inputCas,outputStream)
  sentences = luajava.newInstance("org.json.JSONArray")
  beginsent = luajava.newInstance("org.json.JSONArray")
  endsent = luajava.newInstance("org.json.JSONArray")
  send = luajava.newInstance("org.json.JSONArray")
  
  local result = util:select(inputCas,sentence):iterator()
  while result:hasNext() do
    local x = result:next()
	  sentences:put(x:getCoveredText())
	  beginsent:put(x:getBegin())
    endsent:put(x:getEnd())
  end
  send:put(sentences)
  send:put(beginsent)
  send:out(endsent)
end

function deserialize(inputCas,inputStream)
  inputCas:reset()
  deserial:deserialize(inputStream,inputCas:getCas(),true)
end