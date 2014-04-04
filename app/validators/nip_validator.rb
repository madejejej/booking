class NIPValidator < ActiveModel::Validator
  # source: http://pl.wikipedia.org/wiki/NIP/Implementacja#Implementacja_algorytmu_w_j.C4.99zyku_Ruby
  def validate(record)
    if record.nip.length === 10 && record.nip.match(/^\d+$/)
      weights = [6, 5, 7, 2, 3, 4, 5, 6, 7]
      nip = (record.nip.split //).collect &:to_i
      checksum = weights.inject(0) { |sum, weight| sum + weight * nip.shift }
      return checksum % 11 === nip.shift
    else
      return false
    end
  end
end
