/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   Footer.js                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: c3b5aw <dev@c3b5aw.dev>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/10/18 16:01:42 by c3b5aw            #+#    #+#             */
/*   Updated: 2021/10/21 19:55:28 by c3b5aw           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

import { makeStyles } from "@mui/styles";
import { Container, Grid, Typography, Link } from "@mui/material";
import TwitterIcon from '@mui/icons-material/Twitter';
import GitHubIcon from '@mui/icons-material/GitHub';
import EmailIcon from '@mui/icons-material/Email';

const useStyles = makeStyles((theme: Theme) => ({
	footer: {
		width: '100%',
		height: 60,
		borderTop: `1px solid ${ theme.palette.divider }`,
		marginTop: 50,
	},
	ad: {
		marginTop: 20,
	},
	contactComponent: {
		marginTop: 20,
		textAlign: 'right',
		'& > a > svg': {
			marginRight: 40,
			color: theme.palette.text.primary,
		}
	},
}));

export function Footer() {
	const cls = useStyles();

	const openTwitter = () => window.open('https://twitter.com/c3b5aw', '_blank');
	const openGithub = () => window.open('https://github.com/c3b5aw', '_blank');
	const openMail = () => window.open('mailto:dev@c3b5aw.dev', '_blank');

	return (
		<Container maxWidth='md' className={ cls.footer }>
			<Grid container direction='row' 
				justify='center' alignItems='center'>
				<Grid item xs={6} className={ cls.ad }>
					<Typography>
						- Built for 42-inception.
					</Typography>
				</Grid>
				<Grid item xs={6} className={ cls.contactComponent }>
					<Link onClick={() => openTwitter()}><TwitterIcon /></Link>
					<Link onClick={() => openGithub()}><GitHubIcon /></Link>
					<Link onClick={() => openMail()}><EmailIcon /></Link>
				</Grid>
			</Grid>
		</Container>
	)
}
