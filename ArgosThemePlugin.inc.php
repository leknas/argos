<?php
import('lib.pkp.classes.plugins.ThemePlugin');
class ArgosThemePlugin extends ThemePlugin {

    /**
     * Load the custom styles for our theme
     * @return null
     */
    public function init() {
        $this->setParent('healthsciencesthemeplugin');
//        $this->addStyle('stylesheet', 'styles/index.less');
        
        $this->addStyle(
				'fonts',
				'https://fonts.googleapis.com/css2?family=EB+Garamond:ital,wght@0,400;0,600;1,400;1,600&family=Roboto:ital,wght@0,300;0,400;0,700;1,300;1,400;1,700',
				array('baseUrl' => '')
			);
			$this->modifyStyle('stylesheet', array('addLess' => array('styles/index.less')));
    }

    /**
     * Get the display name of this theme
     * @return string
     */
    function getDisplayName() {
        return 'Argos Theme';
    }

    /**
     * Get the description of this plugin
     * @return string
     */
    function getDescription() {
        return 'A Child Theme for the journal "Argos" based on Health Sciences Theme.';
    }
}
