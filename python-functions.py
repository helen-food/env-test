import spacy

nlp = spacy.load("model/en_core_web_sm/en_core_web_sm-2.2.5")

def get_token_attributes(stringlist):
  """Takes a list of strings, tokenises, parses and tags them, and returns the attributes of each token"""
  tokens = []
  for item in stringlist:
    doc = nlp(item)
    for token in doc:
      tokens.append([token.text, token.lemma_, token.pos_, token.tag_, token.dep_,
                    token.shape_, token.is_alpha, token.is_stop])
  return tokens
