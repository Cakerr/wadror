require 'spec_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    BeermappingApi.stub(:places_in).with("kumpula").and_return(
        [ Place.new(:name => "Oljenkorsi") ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if more than one is returned by the API, they are all shown at the page" do
    BeermappingApi.stub(:places_in).with("helsinki").and_return(
        [Place.new(:name => "Oljenkorsi"), Place.new(:name => "William K")]
    )

    visit places_path
    fill_in('city', with: 'helsinki')
    click_button "Search"

    expect(page).to have_content "William K"
    expect(page).to have_content "Oljenkorsi"
  end

  it "if no places is returned by the API, notice message is shown at the page" do
    BeermappingApi.stub(:places_is).with("asd").and_return([])

    visit places_path
    fill_in('city', with: 'asd')
    click_button "Search"

    expect(page).to have_content "No locations in asd"
  end
end