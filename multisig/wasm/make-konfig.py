import sys

MAX_LEN = 100

class Item(object):
  def __init__(self, len):
    assert isinstance(len, int)
    self.__len = len

  def len(self):
    return self.__len

  def output(self, indent, out):
    del indent, out
    assert False

class Token(Item):
  def __init__(self, value):
    super(Token, self).__init__(len(value) + 1)
    self.__value = value
  
  def output(self, indent, out):
    del indent
    out.append(self.__value)

class FunctionCall(Item):
  def __init__(self, name, args):
    super(FunctionCall, self).__init__(len(name) + 2 + sum([a.len() for a in args]) + 2 * len(args))
    self.__name = name
    self.__args = args

  def output(self, indent, out):
    if self.len() < MAX_LEN:
      out.append(self.__name)
      out.append('(')
      had = False
      for a in self.__args:
        if had:
          out.append(', ')
        had = True
        a.output(indent + 1, out)
      out.append(')')
    elif not self.__args:
      out.append(self.__name)
      out.append('()')
    else:
      out.append(self.__name)
      out.append('\n')
      out.append(INDENTS[indent])
      out.append('( ')
      had = False
      for a in self.__args:
        if had:
          out.append('\n')
          out.append(INDENTS[indent])
          out.append(', ')
        had = True
        a.output(indent + 1, out)
      out.append('\n')
      out.append(INDENTS[indent])
      out.append(')')

class ConcatFunction(Item):
  def __init__(self, args):
    super(ConcatFunction, self).__init__(sum([a.len() for a in args]) + len(args))
    self.__args = args

  def output(self, indent, out):
    if self.len() < MAX_LEN:
      had = False
      for a in self.__args:
        if had:
          out.append(' ')
        had = True
        a.output(indent + 1, out)
    else:
      assert self.__args
      self.__args[0].output(indent + 2, out)
      for a in self.__args[1:]:
        out.append('\n')
        out.append(INDENTS[indent + 1])
        a.output(indent + 2, out)

class ConcatSeparatorFunction(Item):
  def __init__(self, separator, args):
    super(ConcatSeparatorFunction, self).__init__(sum([a.len() for a in args]) + (2 + len(separator)) * len(args))
    self.__args = args
    self.__separator = separator

  def output(self, indent, out):
    if self.len() < MAX_LEN:
      had = False
      for a in self.__args:
        if had:
          out.append(' ')
          out.append(self.__separator)
          out.append(' ')
        had = True
        a.output(indent + 1, out)
    else:
      assert self.__args
      self.__args[0].output(indent + 2, out)
      for a in self.__args[1:]:
        out.append('\n')
        out.append(INDENTS[indent + 1])
        out.append(self.__separator)
        out.append(' ')
        a.output(indent + 2, out)

class Separator:
  def __init__(self, one_liner='', multi_liner='', new_line_before=0, new_line_after=0, own_indent_delta=0, next_indent_delta=0):
    self.__one_liner = one_liner
    self.__multi_liner = multi_liner
    self.__new_line_before = new_line_before
    self.__new_line_after = new_line_after
    self.__own_indent_delta = own_indent_delta
    self.__next_indent_delta = next_indent_delta

  def len(self):
    return len(self.__one_liner)

  def oneLiner(self, out):
    out.append(self.__one_liner)

  def multiLiner(self, indent, out):
    if self.__new_line_before:
      out.append('\n')
      out.append(INDENTS[indent + self.__own_indent_delta])
    out.append(self.__multi_liner)
    indent = indent + self.__next_indent_delta
    if self.__new_line_after:
      out.append('\n')
      out.append(INDENTS[indent])
    return indent


class SpecialSyntax(Item):
  def __init__(self, separators, elements):
    super(SpecialSyntax, self).__init__(sum([s.len() for s in separators]) + sum([e.len() for e in elements]))
    assert len(separators) == len(elements) + 1
    self.__separators = separators
    self.__elements = elements

  def output(self, indent, out):
    if self.len() < MAX_LEN:
      for i in range(0, len(self.__elements)):
        self.__separators[i].oneLiner(out)
        self.__elements[i].output(indent, out)
      self.__separators[-1].oneLiner(out)
    else:
      for i in range(0, len(self.__elements)):
        indent = self.__separators[i].multiLiner(indent, out)
        self.__elements[i].output(indent, out)
      self.__separators[-1].multiLiner(indent, out)

class Tag(Item):
  def __init__(self, name, args):
    super(Tag, self).__init__(2 * len(name) + 3 + sum([a.len() for a in args]) + len(args))
    self.__name = name
    self.__args = args

  def output(self, indent, out):
    if self.len() < MAX_LEN:
      out.append(self.__name)
      had = False
      for a in self.__args:
        if had:
          out.append(' ')
        had = True
        a.output(indent + 1, out)
      out.append('</')
      out.append(self.__name[1:])
    else:
      out.append(self.__name)
      for a in self.__args:
        out.append('\n')
        out.append(INDENTS[indent])
        a.output(indent + 1, out)
      out.append('\n')
      out.append(INDENTS[indent - 1])
      out.append('</')
      out.append(self.__name[1:])

class ConstantFunction(Item):
  def __init__(self, value):
    super(ConstantFunction, self).__init__(len(value) + 1)
    self.__value = value
  
  def output(self, indent, out):
    del indent
    out.append(self.__value)

class EmptyList(ConstantFunction):
  def __init__(self, value):
    super(EmptyList, self).__init__(value)

def error(s, index):
  if index > 10:
    return "%d '%s__[%s]__%s'" % (index, s[index-10:index], s[index], s[index + 1: index+10])
  else:
    return "%d '%s__[%s]__%s'" % (index, s[0:index], s[index], s[index + 1: index+10])

def skipSpaces(s, index):
  while index < len(s) and s[index].isspace():
    index += 1
  return index

def loadValue(s, index):
  if s[index] == '{':
    return loadKast(s, index)
  if s[index] == '[':
    return loadList(s, index)
  if s[index] == "'":
    return loadString(s, index)

  return loadUnquotedValue(s, index)

def loadString(s, index):
  assert s[index] == "'"
  index += 1
  start = index
  while s[index] != "'":
    if s[index] == '\\':
      index += 1
    index += 1
  return (s[start:index], index + 1)

def loadUnquotedValue(s, index):
  assert s[index].isalnum(), error(s, index)
  start = index
  while s[index].isalnum():
    index += 1
  assert s[index].isspace() or s[index] in ",}]", error(s, index)
  return (s[start:index], index)

def loadList(s, index):
  result = []
  assert s[index] == '[', error(s, index)
  index = skipSpaces(s, index + 1)
  assert index < len(s)
  while s[index] != ']':
    (value, index) = loadValue(s, index)
    result.append(value)

    index = skipSpaces(s, index)
    assert index < len(s)
    if s[index] == ',':
      index = skipSpaces(s, index + 1)
      assert index < len(s)
  return (result, index + 1)

def loadKast(s, index):
  result = {}
  assert s[index] == '{', error(s, index)
  index = skipSpaces(s, index + 1)
  assert index < len(s)
  while s[index] != '}':
    assert s[index] == "'", error(s, index)
    next_index = s.find("'", index + 1)
    assert next_index >= 0

    key = s[index + 1 : next_index]

    index = skipSpaces(s, next_index + 1)
    assert index < len(s)
    assert s[index] == ':', error(s, index)
    index = skipSpaces(s, index + 1)
    assert index < len(s)

    (value, index) = loadValue(s, index)
    result[key] = value
    index = skipSpaces(s, index)
    assert index < len(s)
    if s[index] == ',':
      index = skipSpaces(s, index + 1)
      assert index < len(s)
  return (result, index + 1)

def convertArgs(args, separator):
  output = []
  had = False
  for a in args:
    if had and separator:
      output.append((SEPARATOR, separator))
    had = True
    convertDispatch(a, output)
  return output

def convertKSequence(items):
  items = [convertDispatch(a) for a in items]
  return ConcatSeparatorFunction('~>', items)

NORMAL_FUNCTIONS = set([
  'callTx',
  'checkAccountBalance',
  'checkAccountCode',
  'checkAccountNonce',
  'checkAccountStorage',
  'checkExpectLogs',
  'checkExpectMessage',
  'checkExpectOut',
  'checkExpectStatus',
  'checkedAccount',
  'clearCheckedAccounts',
  'deployTx',
  'newAddress',
  'setAccount',
  'ListItem',
  'OK',
  'UserError',
])

SPECIAL_SYNTAX = {
  '_|->_': [
    Separator(),
    Separator(one_liner=' |-> ', multi_liner='|-> ', new_line_before=True, own_indent_delta=1, next_indent_delta=2),
    Separator(),
  ],
  'aCvtOp': [
    Separator(),
    Separator(one_liner='.', multi_liner='.'),
    Separator(),
  ],
  'aFuncType': [
    Separator(),
    Separator(one_liner=' -> ', multi_liner='-> ', new_line_before=True, own_indent_delta=1, next_indent_delta=2),
    Separator(),
  ],
  'aGlobalType': [
    Separator(),
    Separator(one_liner=' ', multi_liner=' '),
    Separator(),
  ],
  'aIBinOp': [
    Separator(),
    Separator(one_liner='.', multi_liner='.'),
    Separator(),
  ],
  'aIConst': [
    Separator(),
    Separator(one_liner='.const ', multi_liner='.const '),
    Separator(),
  ],
  'aIRelOp': [
    Separator(),
    Separator(one_liner='.', multi_liner='.'),
    Separator(),
  ],
  'aIUnOp': [
    Separator(),
    Separator(one_liner='.', multi_liner='.'),
    Separator(),
  ],
  'aTestOp': [
    Separator(),
    Separator(one_liner='.', multi_liner='.'),
    Separator(),
  ],
  'aVecType': [
    Separator(one_liner='[', multi_liner='[', next_indent_delta = 1),
    Separator(one_liner=']', multi_liner=']', own_indent_delta = -1)
  ],
}

MAPPED_FUNCTIONS = {
  'aBlock': '#block',
  'aBr': '#br',
  'aBr_if': '#br_if',
  'aBr_table': '#br_table',
  'aCall': '#call',
  'aCall_indirect': '#call_indirect',
  'aDataDefn': '#data',
  'aElemDefn': '#elem',
  'aExportDefn': '#export',
  'aFuncDefn': '#func',
  'aFuncDesc': '#funcDesc',
  'aGlobal.get': '#global.get',
  'aGlobal.set': '#global.set',
  'aGlobalDefn': '#global',
  'aImportDefn': '#import',
  'aLoad': '#load',
  'aLocal.get': '#local.get',
  'aLocal.set': '#local.set',
  'aLocal.tee': '#local.tee',
  'aLoop': '#loop',
  'aMemoryDefn': '#memory',
  'aModuleDecl': '#module',
  'aStore': '#store',
  'aTableDefn': '#table',
  'aTypeDefn': '#type',
  'funcMeta': '#meta',
  'limitsMin': '#limitsMin',
  'limitsMinMax': '#limits',
  'moduleMeta': '#meta',
}

CONSTANT_FUNCTIONS = set([
  'i32',
  'i64',
  '.AccountCellMap',
  '.Code',
  '.FuncDefCellMap',
  '.GlobalInstCellMap',
  '.List',
  '.Map',
  '.MemInstCellMap',
  '.ModuleInstCellMap',
  '.Set',
  '.TabInstCellMap',
])

CONCAT_FUNCTIONS = set([
  '___WASM-COMMON-SYNTAX_Defns_Defn_Defns',
  '___WASM-COMMON-SYNTAX_Instrs_Instr_Instrs',
  '_List_',
  '_Map_',
  'listInt',
  'listValTypes',
])

CONCAT_SYMBOL_FUNCTIONS = {
  '_:__ELROND_BytesStack_Bytes_BytesStack"}_BytesStack': ':',
}

MAPPED_CONSTANTS = {
  'aDrop': 'drop',
  'aEqz': 'eqz',
  'aExtend_i32_u': 'extend_i32_u',
  'aGrow': 'memory.grow',
  'aPopcnt': 'popcnt',
  'aReturn': 'return',
  'aSelect': 'select',
  'aUnreachable': 'unreachable',
  'aWrap_i64': 'wrap_i64',
  'intAdd': 'add',
  'intAnd': 'and',
  'intDiv_s': 'div_s',
  'intDiv_u': 'div_u',
  'intEq': 'eq',
  'intGe_s': 'ge_s',
  'intGe_u': 'ge_u',
  'intGt_s': 'gt_s',
  'intGt_u': 'gt_u',
  'intLe_s': 'le_s',
  'intLe_u': 'le_u',
  'intLt_s': 'lt_s',
  'intLt_u': 'lt_u',
  'intMul': 'mul',
  'intNe': 'ne',
  'intOr': 'or',
  'intRotl': 'rotl',
  'intShl': 'shl',
  'intShr_u': 'shr_u',
  'intSub': 'sub',
  'intXor': 'xor',
  'loadOpLoad': 'load',
  'loadOpLoad8_s': 'load8_s',
  'loadOpLoad8_u': 'load8_u',
  'loadOpLoad16_s': 'load16_s',
  'loadOpLoad16_u': 'load16_u',
  'loadOpLoad32_s': 'load32_s',
  'loadOpLoad32_u': 'load32_u',
  'mutConst': 'const',
  'mutVar': 'var',
  'storeOpStore': 'store',
  'storeOpStore8': 'store8',
  'storeOpStore16': 'store16',
  'storeOpStore32': 'store32',
  '.Identifier': '',
}
EMPTY_LISTS = {
  '.Int_WASM-DATA_OptionalInt': '.Int',
  '.List{"_:__ELROND_BytesStack_Bytes_BytesStack"}_BytesStack': '.BytesStack',
  '.List{"listStmt"}_EmptyStmts': '.EmptyStmts',
  '.List{"listInt"}_Ints': '.Ints',
  '.List{"listValTypes"}_ValTypes': '.ValTypes',
  '.ReturnCode_ELROND-NODE_ReturnCode': '.ReturnCode',
  '.ValStack_WASM-DATA_ValStack': '.ValStack',
}

forgiven = set()

def convertKApply(label, args):
  if label[0] == '<':
    args = [convertDispatch(a) for a in args]
    return Tag(label, args)
  if label in SPECIAL_SYNTAX:
    args = [convertDispatch(a) for a in args]
    separators = SPECIAL_SYNTAX[label]
    assert len(args) == len(separators) - 1
    return SpecialSyntax(separators, args)
  if label in NORMAL_FUNCTIONS:
    args = [convertDispatch(a) for a in args]
    return FunctionCall(label, args)
  if label in MAPPED_FUNCTIONS:
    args = [convertDispatch(a) for a in args]
    new_label = MAPPED_FUNCTIONS[label]
    return FunctionCall(new_label, args)
  if label in CONSTANT_FUNCTIONS:
    assert not args
    return ConstantFunction(label)
  if label in MAPPED_CONSTANTS:
    assert not args
    new_label = MAPPED_CONSTANTS[label]
    return ConstantFunction(new_label)
  if label in EMPTY_LISTS:
    assert not args
    new_label = EMPTY_LISTS[label]
    return EmptyList(new_label)
  if label in CONCAT_FUNCTIONS:
    assert len(args) == 2
    arg_stack = [args[1], args[0]]
    merged_args = []
    while arg_stack:
      arg = arg_stack.pop()
      if arg['node'] != 'KApply' or arg['label'] != label:
        merged_args.append(arg)
        continue
      args = arg['args']
      assert len(args) == 2
      arg_stack.append(args[1])
      arg_stack.append(args[0])
    args = [convertDispatch(a) for a in merged_args]
    if isinstance(args[-1], EmptyList):
      args.pop()
    return ConcatFunction(args)
  if label in CONCAT_SYMBOL_FUNCTIONS:
    merged_args = []
    while True:
      assert len(args) == 2
      merged_args.append(args[0])
      second = args[1]
      if second['node'] != 'KApply' or second['label'] != label:
        merged_args.append(second)
        break
      args = second['args']
    args = [convertDispatch(a) for a in merged_args]
    separator = CONCAT_SYMBOL_FUNCTIONS[label]
    return ConcatSeparatorFunction(separator, args)
  if len(forgiven) < 10:
    print(label)
    forgiven.add(label)
    return
  else:
    forgiven.add(label)
  assert False, 'KApply: label=%s' % sorted(list(forgiven))

def convertKToken(token, sort):
  if sort == 'Bytes':
    assert token[0] == 'b'
    return Token('String2Bytes(#parseWasmString(%s))' % token[1:])
  if sort in ['Int', 'Bool', 'WasmStringToken']:
    return Token(token)
  if sort == 'String':
    return Token('#parseWasmString(%s)' % token)
  print(token)
  print(sort)
  assert False, 'convertKToken(token=%s, sort=%s)' % (token, sort)

def convertDispatch(d):
  node = d['node']
  if node == 'KApply':
    label = d['label']
    args = d['args']
    retv = convertKApply(label, args)
    assert retv is not None
    return retv
  if node == 'KSequence':
    items = d['items']
    retv = convertKSequence(items)
    assert retv is not None
    return retv
  if node == 'KToken':
    token = d['token']
    sort = d['sort']
    retv = convertKToken(token, sort)
    assert retv is not None
    return retv
  assert False, "Dispatch %s node=%s" % (d.keys(), d['node'])

def convert(d, output):
  convertDispatch(d['term']).output(1, output)

INDENTS = ['  ' * indent for indent in range(0, 1000)]

SEPARATOR = 0

def main(name, argv):
  if len(argv) != 2:
    print('Usage: %s <json-file> <output-file>' % name)
    exit(1)

  sys.setrecursionlimit(10000)

  json_file = argv[0]
  output_file = argv[1]

  with open(json_file, 'r') as f:
    contents = f.read()
  (parsed, _) = loadKast(contents, 0)
  output = []
  convert(parsed, output)

  with open(output_file, 'w') as f:
    f.write(''.join(output))

if __name__ == '__main__':
  main(sys.argv[0], sys.argv[1:])