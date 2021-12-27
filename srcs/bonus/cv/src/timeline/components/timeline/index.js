/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   index.js                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: c3b5aw <dev@c3b5aw.dev>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/10/21 16:29:08 by c3b5aw            #+#    #+#             */
/*   Updated: 2021/10/21 16:29:08 by c3b5aw           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

/* eslint-disable no-tabs */
import React from 'react';
import PropTypes from 'prop-types';
import styled from 'styled-components';

const TimelineComponent = styled.div`
	padding: 10px 20px 20px;
	width: 100%;
`;

const Timeline = (props) => {
	const { children } = props;

	return (
		<TimelineComponent className='timeline-component'>
			{children}
		</TimelineComponent>
	);
};

Timeline.propTypes = {
	children: PropTypes.node.isRequired,
};

export default Timeline;
