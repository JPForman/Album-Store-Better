require('album')
require('rspec')
require('song')



describe('.#Album') do

  before(:each) do
    @album1 = Album.new("Blue", 'Hervana', 1994, 'Grunge', nil)
    @album2 = Album.new("Red", 'T.Swiftly', 2003, 'Pop', nil)
    @album1.save
    @album2.save
  end

  after(:each) do
    Album.clear
  end

  describe('#==') do
    it("is the same album if it has the same attributes") do
      album3 = Album.new("Blue", 'Hervana', 1994, 'Grunge', nil)
      expect(@album1).to(eq(album3))
    end
  end


  describe('#save') do
    it ("saves an album") do
      expect(Album.all).to(eq([@album1, @album2]))
    end
  end

  describe(".clear") do
    it("clears all albums") do
      Album.clear
      expect(Album.all).to(eq([]))
    end
  end

  describe('.find') do
    it("finds an album by id") do
      expect(Album.find(@album1.id)).to(eq(@album1))
    end
  end

  describe('#update') do
    it("updates an album by id") do
      @album1.update("Yellow", "", "", nil)
      expect(@album1.name).to(eq('Yellow'))
      expect(@album1.artist).to(eq('Hervana'))
    end
  end

  describe('#delete') do
    it("deletes an album by id") do
      @album1.delete()
      expect(Album.all).to(eq([@album2]))
    end
  end

  describe('.search') do
    it("returns an array of albums by name") do
      album3 = Album.new("Red Letter Day", 'Death Staves', 2001, 'Rock', nil)
      album3.save
      expect(Album.search('Red')).to(eq([@album2, album3]))
    end
  end

  describe('#songs') do
    it("returns an album's songs") do
      album = Album.new("Giant Steps", 'John Coltrane','1963', 'Jazz', nil)
      album.save()
      song = Song.new("Naima", album.id, nil)
      song.save()
      song2 = Song.new("Cousin Mary", album.id, nil)
      song2.save()
      expect(album.songs).to(eq([song, song2]))
    end
  end

end
