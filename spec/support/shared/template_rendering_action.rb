shared_examples 'template rendering action' do |template|
  it { is_expected.to render_template template }
end
