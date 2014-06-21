load("parses2.rb")

def makeShikigi(ar)#与えられた数字の配列に対して、それを葉とする全ての式木を作る
  shikis = ["+","-","*","/"]
  n = ar.length
  a = []
  if n==1
    return [ParseNodes.new(ar[0])]
  else
    for i in 1..n-1
      makeShikigi(ar[0...i]).each do |lnodes|
      #左側の個数iに対して可能な式木と
        makeShikigi(ar[i...n]).each do |rnodes|
        #右側の個数n-iに対して可能な式木を組み合わせる。
          shikis.each do |shiki|
            #演算子それぞれを用いる。
            a << ParseNodes.new(shiki,lnodes,rnodes)
          end
        end
      end
    end
  end
  a
end

def find10(n)
  numbers = (0..9).to_a
  a = []
  numbers.repeated_combination(n) do |combi|
    #combiは0から9までの重複ありのnこの配列
    catch(:ok){
      combi.permutation do |permu| #combiを並べ替えた全て
        makeShikigi(permu).each do |shikigi|
          if shikigi.value == 10 #値が10になるものがあればok
            p shikigi.inorder
            throw(:ok)
          end
        end
      end
      #なかったらaに加える。
      puts combi.to_s + "can't be 10."
      a << combi
    }
  end
  a
end

