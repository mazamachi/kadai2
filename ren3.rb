load("parses2.rb")

def makeShikigi(ar)
  shikis = ["+","-","*","/"]
  n = ar.length
  a = []
  if n==1
    return [ParseNodes.new(ar[0])]
  else
    for i in 1..n-1
      makeShikigi(ar[0...i]).each do |lnodes|
        makeShikigi(ar[i..-1]).each do |rnodes|
          shikis.each do |shiki|
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
    catch(:ok){
      combi.permutation do |permu|
        makeShikigi(permu).each do |shikigi|
          if shikigi.value == 10
            p shikigi.inorder
            throw(:ok)
          end
        end
      end
      puts combi.to_s + "can't be 10."
      a << combi
    }
  end
  a
end

