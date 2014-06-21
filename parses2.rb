# -*- coding: utf-8 -*-
# 式木を表すノードのクラス
# 簡単のため、演算ノードと葉を兼用
#

class ParseNodes
  attr_accessor :op, :left, :right
  def initialize(op,left=nil,right=nil)
    @op = op # 演算子
    @left = left # 左の子(葉の時は使用しない)
    @right = right # 右の子(葉の時は使用しない)
  end
  
  def value                                    # 式の値を再帰的に計算する
    if @op.class != String # @opが数値なら葉
      return @op                  # 葉ならその値を返す
    else
      l = @left.value  # 左の子の値
      r = @right.value # 右の子の値
      if l=="Devided by 0"|| r=="Devided by 0"
        return "Devided by 0"
      end
      case @op # @opの値によって場合分け
      when "+"
        return l+r
      when "-"
        return l-r
      when "*"
        return l*r
      when "/"
        if r == 0
          return "Devided by 0"
        end
        return Rational(l,r) # lとrが整数の場合は整数の割り算。実数の割り算をしたい場合はl.to_f/rなどとする。
      when "^"
        return l**r
      end
    end
  end
  
  def inorder   # in orderの文字列に変換する
    if @op.class != String
      return @op.to_s # 葉ならその値の文字列
    else
      return "(" + @left.inorder + @op + @right.inorder + ")"
    end
  end
  
  def preorder  # pre orderの文字列に変換する
    if @op.class != String
      return @op.to_s  # 葉ならその値の文字列
    else
      return @op + "(" + @left.preorder + "," + @right.preorder + ")"
    end
  end
  
  def postorder  # post orderの文字列に変換する
    if @op.class != String
      return @op.to_s  # 葉ならその値の文字列
    else
      return @left.postorder + " " + @right.postorder + @op
    end
  end

  def replaceConstant(c1,c2)
    if self.op.class == String
      @left.replaceConstant(c1,c2)
      @right.replaceConstant(c1,c2)
    else
      if @op == c1
        @op = c2
      end
    end
  end
end

def test
  x = ParseNodes.new("*",             # *の演算子
                   ParseNodes.new(2), # *の左の式
                   ParseNodes.new("+",ParseNodes.new(3),ParseNodes.new(4)) # * の右の式
                   )
  x.replaceConstant(4,5)
  print x.inorder,"\n"   # in orderで表示
  print x.preorder,"\n"  # pre orderで表示
  print x.postorder,"\n" # post orderで表示
  print x.value,"\n"     # 値を表示
  return x.value
end
