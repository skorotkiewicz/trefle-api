# == Schema Information
#
# Table name: species
#
#  id                               :bigint           not null, primary key
#  adapted_to_coarse_textured_soils :boolean
#  adapted_to_fine_textured_soils   :boolean
#  adapted_to_medium_textured_soils :boolean
#  anaerobic_tolerance              :string(255)
#  atmospheric_humidity             :integer
#  author                           :string(255)
#  average_height_cm                :integer
#  bibliography                     :text
#  biological_type                  :integer
#  biological_type_raw              :string
#  bloom_months                     :bigint           default(0), not null
#  c_n_ratio                        :string(255)
#  caco_3_tolerance                 :string(255)
#  checked_at                       :datetime
#  common_name                      :string(255)
#  complete_data                    :boolean
#  completion_ratio                 :integer
#  dissemination                    :integer          default(0), not null
#  dissemination_raw                :string
#  duration                         :bigint           default(0), not null
#  edible                           :boolean
#  edible_part                      :integer          default(0), not null
#  family_common_name               :string(255)
#  family_name                      :string
#  flower_color                     :bigint           default(0), not null
#  flower_conspicuous               :boolean
#  foliage_color                    :bigint           default(0), not null
#  foliage_texture                  :integer
#  frost_free_days_minimum          :float
#  fruit_color                      :bigint           default(0), not null
#  fruit_conspicuous                :boolean
#  fruit_months                     :bigint           default(0), not null
#  fruit_seed_persistence           :boolean
#  fruit_shape                      :integer
#  fruit_shape_raw                  :string
#  full_token                       :text
#  gbif_score                       :integer          default(0), not null
#  genus_name                       :string
#  ground_humidity                  :integer
#  growth_form                      :string(255)
#  growth_habit                     :string(255)
#  growth_months                    :bigint           default(0), not null
#  growth_rate                      :string(255)
#  hardiness_zone                   :integer
#  images_count                     :integer          default(0), not null
#  inflorescence_form               :integer
#  inflorescence_raw                :string
#  inflorescence_type               :integer
#  inserted_at                      :datetime         not null
#  known_allelopath                 :boolean
#  leaf_retention                   :boolean
#  lifespan                         :string(255)
#  light                            :integer
#  ligneous_type                    :integer
#  main_image_url                   :string
#  maturation_order                 :string
#  maturation_order_raw             :string
#  maximum_height_cm                :integer
#  maximum_precipitation_mm         :integer
#  maximum_temperature_deg_c        :decimal(, )
#  maximum_temperature_deg_f        :decimal(, )
#  minimum_precipitation_mm         :integer
#  minimum_root_depth_cm            :integer
#  minimum_temperature_deg_c        :decimal(, )
#  minimum_temperature_deg_f        :decimal(, )
#  nitrogen_fixation                :string(255)
#  observations                     :text
#  ph_maximum                       :float
#  ph_minimum                       :float
#  phylum                           :string
#  planting_days_to_harvest         :integer
#  planting_description             :text
#  planting_row_spacing_cm          :integer
#  planting_sowing_description      :text
#  planting_spread_cm               :integer
#  pollinisation                    :integer          default(0), not null
#  pollinisation_raw                :string
#  propagated_by                    :bigint           default(0), not null
#  protein_potential                :string(255)
#  rank                             :integer
#  reviewed_at                      :datetime
#  scientific_name                  :string(255)
#  sexuality                        :integer          default(0), not null
#  sexuality_raw                    :string
#  shape_and_orientation            :string(255)
#  slug                             :string(255)
#  soil_nutriments                  :integer
#  soil_salinity                    :integer
#  soil_texture                     :integer
#  sources_count                    :integer          default(0), not null
#  status                           :integer
#  synonyms_count                   :integer          default(0), not null
#  token                            :text
#  toxicity                         :integer
#  vegetable                        :boolean
#  wiki_score                       :integer
#  year                             :integer
#  created_at                       :datetime
#  updated_at                       :datetime         not null
#  genus_id                         :integer
#  main_species_id                  :integer
#  plant_id                         :bigint
#
# Indexes
#
#  index_species_on_author                           (author)
#  index_species_on_average_height_cm                (average_height_cm)
#  index_species_on_common_name                      (common_name)
#  index_species_on_family_common_name               (family_common_name)
#  index_species_on_flower_conspicuous               (flower_conspicuous)
#  index_species_on_genus_name                       (genus_name)
#  index_species_on_light                            (light)
#  index_species_on_main_species_id_and_common_name  (main_species_id,common_name)
#  index_species_on_main_species_id_and_gbif_score   (main_species_id,gbif_score)
#  index_species_on_maximum_height_cm                (maximum_height_cm)
#  index_species_on_minimum_precipitation_mm         (minimum_precipitation_mm)
#  index_species_on_minimum_root_depth_cm            (minimum_root_depth_cm)
#  index_species_on_minimum_temperature_deg_f        (minimum_temperature_deg_f)
#  index_species_on_planting_days_to_harvest         (planting_days_to_harvest)
#  index_species_on_planting_row_spacing_cm          (planting_row_spacing_cm)
#  index_species_on_planting_spread_cm               (planting_spread_cm)
#  index_species_on_slug                             (slug)
#  index_species_on_token                            (token)
#  species_gbif_score_idx                            (gbif_score)
#  species_genus_id_index                            (genus_id)
#  species_main_species_id_index                     (main_species_id)
#  species_plant_id_index                            (plant_id)
#  species_scientific_name_index                     (scientific_name) UNIQUE
#
# Foreign Keys
#
#  species_plant_id_fkey  (plant_id => plants.id)
#
require 'rails_helper'

RSpec.describe Species, type: :model do # rubocop:todo Metrics/BlockLength

  let(:genus) { Genus.last }

  it 'Can be created' do
    plant = create(:plant, genus_id: genus.id)
    species = Species.create(
      plant: plant,
      genus: genus,
      scientific_name: "#{genus.name} testacae"
    )
    expect(species.valid?).to be(true)
    expect(species.persisted?).to be(true)
  end

  it 'Can create plant itself' do
    species = Species.create(
      genus: genus,
      scientific_name: "#{genus.name} testacae"
    )
    pp species.errors.full_messages unless species.valid?
    expect(species.valid?).to be(true)
    expect(species.persisted?).to be(true)
    expect(species.plant).not_to be(nil)
    expect(species.plant.scientific_name).to eq(species.scientific_name)
  end

  it 'Can create genus itself' do
    species = Species.create(
      scientific_name: "#{genus.name} testacae"
    )
    pp species.errors.full_messages unless species.valid?
    expect(species.valid?).to be(true)
    expect(species.persisted?).to be(true)
    expect(species.plant).not_to be(nil)
    expect(species.plant.scientific_name).to eq(species.scientific_name)
    expect(species.genus).not_to be(nil)
    expect(species.genus.id).to eq(genus.id)
    pp species
  end

  it 'Cannot create genus itself if doesnt exists' do
    species = Species.create(
      scientific_name: 'Notagenus testacae'
    )
    expect(species.valid?).to be(false)
    expect(species.persisted?).to be(false)
    expect(species.plant).to be(nil)
    expect(species.genus).to be(nil)
  end

  it 'Cannot create with an invalid name' do
    species = Species.create(
      scientific_name: genus.name.to_s
    )
    expect(species.valid?).to be(false)
    expect(species.persisted?).to be(false)
    expect(species.plant).to be(nil)
    expect(species.genus_id).to be(genus.id)
  end

  it 'Cannot create with an invalid rank' do
    species = Species.create(
      scientific_name: "#{genus.name} terifolia ssp. faraereaa",
      rank: :species
    )
    expect(species.valid?).to be(false)
    expect(species.persisted?).to be(false)
    expect(species.plant).to be(nil)
    expect(species.genus_id).to be(genus.id)
  end

  it 'Cannot create with an authorship in it' do
    species = Species.create(
      scientific_name: "#{genus.name} terifolia (Al. Green)",
      rank: :species
    )
    expect(species.valid?).to be(false)
    expect(species.persisted?).to be(false)
    expect(species.plant).to be(nil)
    expect(species.genus_id).to be(genus.id)
  end

  it 'Can be create with valid names' do
    [
      { scientific_name: "#{genus.name} rodriga", rank: :species },
      { scientific_name: "#{genus.name} decurtata subsp. platensis", rank: :ssp },
      { scientific_name: "#{genus.name} omanense var. yemenense", rank: :var },
      { scientific_name: "#{genus.name} crenulatoserrulatum f. hakonense", rank: :form },
      { scientific_name: "#{genus.name} × odorus", rank: :hybrid },
      { scientific_name: "#{genus.name} diversifolia subvar. multifoliolata", rank: :subvar }
    ].each do |e|
      species = Species.create(e)
      pp species.errors.full_messages unless species.valid?
      expect(species.valid?).to be(true)
      expect(species.persisted?).to be(true)
      # expect(species.plant.scientific_name).to eq(e[:scientific_name].split(' ').first(2).join(' '))
      expect(species.genus.id).to eq(genus.id)
      expect(species.plant.genus.id).to eq(genus.id)
    end
  end

  it 'Cannot create with an invalid names' do
    [
      { scientific_name: 'Wtf (Al. Green)', rank: :species },
      { scientific_name: 'Wtf terifolia (Al. Green)', rank: :species },
      { scientific_name: "#{genus.name} Terifolia", rank: :species },
      { scientific_name: "#{genus.name} terifolia (Al. Green)", rank: :species },
      { scientific_name: "#{genus.name} terifolia (Al. Green)", rank: :ssp },
      { scientific_name: "#{genus.name} terifolia ssp. faraereaa", rank: :var },
      { scientific_name: "#{genus.name} terifolia var. faraereaa", rank: :ssp },
      { scientific_name: "#{genus.name} terifolia var. ×faraereaa", rank: :form },
      { scientific_name: "#{genus.name} ×complachroma", rank: :hybrid },
      { scientific_name: "#{genus.name} x complachroma", rank: :hybrid },
      { scientific_name: "#{genus.name} Complachroma", rank: :hybrid },
      { scientific_name: "#{genus.name} compla×hroma", rank: :hybrid },
      { scientific_name: "#{genus.name} terifolia fo. faraereaa", rank: :var },
      { scientific_name: "#{genus.name} terifolia subvar. faraereaa", rank: :var }
    ].each do |e|
      species = Species.create(e)
      expect(species.valid?).to be(false)
      expect(species.persisted?).to be(false)
      expect(species.plant).to be(nil)
    end
  end
end
