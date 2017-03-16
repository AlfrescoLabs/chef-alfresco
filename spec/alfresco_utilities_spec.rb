require 'spec_helper'

describe AlfrescoHelper do
  let(:dummy_alfrescohelper) { Class.new { include AlfrescoHelper } }

  describe '#alf_version_gt?' do
    context 'Is 5.2-EA greater than 5.2' do
      it 'returns true' do
        allow_any_instance_of(dummy_alfrescohelper).to receive(:alf_version).and_return('5.2-EA')
        alfrescohelper = dummy_alfrescohelper.new
        res = alfrescohelper.alf_version_gt?('5.2')
        expect(res).to eq(true)
      end
    end

    context 'Is 5.0 greater than 5.0' do
      it 'returns false' do
        allow_any_instance_of(dummy_alfrescohelper).to receive(:alf_version).and_return('5.0')
        alfrescohelper = dummy_alfrescohelper.new
        res = alfrescohelper.alf_version_gt?('5.0')
        expect(res).to eq(false)
      end
    end

    context 'Is 5.0.0 greater than 5.0' do
      it 'returns false' do
        allow_any_instance_of(dummy_alfrescohelper).to receive(:alf_version).and_return('5.0.0')
        alfrescohelper = dummy_alfrescohelper.new
        res = alfrescohelper.alf_version_gt?('5.0')
        expect(res).to eq(false)
      end
    end

    context 'Is 5.1 greater than 5.2' do
      it 'returns false' do
        allow_any_instance_of(dummy_alfrescohelper).to receive(:alf_version).and_return('5.1')
        alfrescohelper = dummy_alfrescohelper.new
        res = alfrescohelper.alf_version_gt?('5.2')
        expect(res).to eq(false)
      end
    end

    context 'Is 5.1 greater than 5.1.3' do
      it 'returns false' do
        allow_any_instance_of(dummy_alfrescohelper).to receive(:alf_version).and_return('5.1')
        alfrescohelper = dummy_alfrescohelper.new
        res = alfrescohelper.alf_version_gt?('5.1.3')
        expect(res).to eq(false)
      end
    end
  end

  describe '#alf_version_ge?' do
    context 'Is 5.2-EA greater or equal than 5.2' do
      it 'returns true' do
        allow_any_instance_of(dummy_alfrescohelper).to receive(:alf_version).and_return('5.2-EA')
        alfrescohelper = dummy_alfrescohelper.new
        res = alfrescohelper.alf_version_ge?('5.2')
        expect(res).to eq(true)
      end
    end

    context 'Is 5.0 greater or equal than 5.0' do
      it 'returns true' do
        allow_any_instance_of(dummy_alfrescohelper).to receive(:alf_version).and_return('5.0')
        alfrescohelper = dummy_alfrescohelper.new
        res = alfrescohelper.alf_version_ge?('5.0')
        expect(res).to eq(true)
      end
    end

    context 'Is 5.0.0 greater or equal than 5.0' do
      it 'returns true' do
        allow_any_instance_of(dummy_alfrescohelper).to receive(:alf_version).and_return('5.0.0')
        alfrescohelper = dummy_alfrescohelper.new
        res = alfrescohelper.alf_version_ge?('5.0')
        expect(res).to eq(true)
      end
    end

    context 'Is 5.1 greater or equal than 5.2' do
      it 'returns false' do
        allow_any_instance_of(dummy_alfrescohelper).to receive(:alf_version).and_return('5.1')
        alfrescohelper = dummy_alfrescohelper.new
        res = alfrescohelper.alf_version_ge?('5.2')
        expect(res).to eq(false)
      end
    end

    context 'Is 5.1 greater or equal than 5.1.3' do
      it 'returns false' do
        allow_any_instance_of(dummy_alfrescohelper).to receive(:alf_version).and_return('5.1')
        alfrescohelper = dummy_alfrescohelper.new
        res = alfrescohelper.alf_version_ge?('5.1.3')
        expect(res).to eq(false)
      end
    end

    context 'Is 5.0.1 greater or equal than 5.1.3' do
      it 'returns false' do
        allow_any_instance_of(dummy_alfrescohelper).to receive(:alf_version).and_return('5.0.1')
        alfrescohelper = dummy_alfrescohelper.new
        res = alfrescohelper.alf_version_ge?('5.1.3')
        expect(res).to eq(false)
      end
    end
  end

  describe '#alf_version_lt?' do
    context 'Is 5.2-EA less than 5.2' do
      it 'returns false' do
        allow_any_instance_of(dummy_alfrescohelper).to receive(:alf_version).and_return('5.2-EA')
        alfrescohelper = dummy_alfrescohelper.new
        res = alfrescohelper.alf_version_lt?('5.2')
        expect(res).to eq(false)
      end
    end

    context 'Is 5.1 less than 5.2' do
      it 'returns true' do
        allow_any_instance_of(dummy_alfrescohelper).to receive(:alf_version).and_return('5.1')
        alfrescohelper = dummy_alfrescohelper.new
        res = alfrescohelper.alf_version_lt?('5.2')
        expect(res).to eq(true)
      end
    end

    context 'Is 5.1 less than 5.1.3' do
      it 'returns true' do
        allow_any_instance_of(dummy_alfrescohelper).to receive(:alf_version).and_return('5.1')
        alfrescohelper = dummy_alfrescohelper.new
        res = alfrescohelper.alf_version_lt?('5.1.3')
        expect(res).to eq(true)
      end
    end

    context 'Is 5.0.1 less than 5.1.3' do
      it 'returns true' do
        allow_any_instance_of(dummy_alfrescohelper).to receive(:alf_version).and_return('5.0.1')
        alfrescohelper = dummy_alfrescohelper.new
        res = alfrescohelper.alf_version_lt?('5.1.3')
        expect(res).to eq(true)
      end
    end
  end

  describe '#alf_version_le?' do
    context 'Is 5.2-EA less or equal than 5.2' do
      it 'returns false' do
        allow_any_instance_of(dummy_alfrescohelper).to receive(:alf_version).and_return('5.2-EA')
        alfrescohelper = dummy_alfrescohelper.new
        res = alfrescohelper.alf_version_le?('5.2')
        expect(res).to eq(false)
      end
    end

    context 'Is 5.0 less or equal than 5.0' do
      it 'returns true' do
        allow_any_instance_of(dummy_alfrescohelper).to receive(:alf_version).and_return('5.0')
        alfrescohelper = dummy_alfrescohelper.new
        res = alfrescohelper.alf_version_le?('5.0')
        expect(res).to eq(true)
      end
    end

    context 'Is 5.0.0 less or equal than 5.0' do
      it 'returns true' do
        allow_any_instance_of(dummy_alfrescohelper).to receive(:alf_version).and_return('5.0.0')
        alfrescohelper = dummy_alfrescohelper.new
        res = alfrescohelper.alf_version_le?('5.0')
        expect(res).to eq(true)
      end
    end

    context 'Is 5.1 less or equal than 5.2' do
      it 'returns true' do
        allow_any_instance_of(dummy_alfrescohelper).to receive(:alf_version).and_return('5.1')
        alfrescohelper = dummy_alfrescohelper.new
        res = alfrescohelper.alf_version_le?('5.2')
        expect(res).to eq(true)
      end
    end

    context 'Is 5.1 less or equal than 5.1.3' do
      it 'returns true' do
        allow_any_instance_of(dummy_alfrescohelper).to receive(:alf_version).and_return('5.1')
        alfrescohelper = dummy_alfrescohelper.new
        res = alfrescohelper.alf_version_le?('5.1.3')
        expect(res).to eq(true)
      end
    end

    context 'Is 5.0.1 less or equal than 5.1.3' do
      it 'returns true' do
        allow_any_instance_of(dummy_alfrescohelper).to receive(:alf_version).and_return('5.0.1')
        alfrescohelper = dummy_alfrescohelper.new
        res = alfrescohelper.alf_version_le?('5.1.3')
        expect(res).to eq(true)
      end
    end
  end
end
